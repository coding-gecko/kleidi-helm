{{/*
Pod template used in Daemonset and Deployment
*/}}
{{- define "kleidi.podTemplate" -}}
metadata:
  labels:
    name: {{ include "kleidi.fullname" . }}
    {{- include "kleidi.selectorLabels" . | nindent 4 }}
  annotations:
    {{- with .Values.podAnnotations }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
spec:
  {{- with .Values.nodeSelector }}
  nodeSelector:
  {{- toYaml . | nindent 4 }}
  {{- end }}
  serviceAccountName: {{ include "kleidi.serviceAccountName" . }}
  {{- with .Values.hostNetwork }}
  hostNetwork: {{ . }}
  {{- end }}
  {{- with .Values.priorityClassName }}
  priorityClassName: {{ . }}
  {{- end }}
  {{- with .Values.global.imagePullSecrets | default .Values.imagePullSecrets }}
  imagePullSecrets:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.hostAliases }}
  hostAliases:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  securityContext:
    {{- toYaml .Values.podSecurityContext | nindent 4 }}
  {{- if .Values.global.softHsm }}
  initContainers:
    - name: kleidi-kms-init
      image: {{ .Values.deployment.kleidiKmsInit.registry | default .Values.global.registry }}/{{ .Values.deployment.kleidiKmsInit.image }}:{{ .Values.deployment.kleidiKmsInit.tag }}
      imagePullPolicy: {{ .Values.global.imagePullPolicy }}
      args:
        - |
          #!/bin/sh
          set -e
          set -x
          ls -lah /var/lib/softhsm/tokens
          # if token exists, skip initialization
          if [ $(ls -1 /var/lib/softhsm/tokens | wc -l) -ge 1 ]; then
            echo "Skipping initialization of softhsm"
            exit 0
          fi

          mkdir -p /var/lib/softhsm/tokens

          TOKEN_LABEL=$(jq -r '.tokenLabel' /opt/softhsm/config.json)
          PIN=$(jq -r '.pin' /opt/softhsm/config.json)
          MODULE_PATH=$(jq -r '.path' /opt/softhsm/config.json)

          softhsm2-util --init-token --free --label $TOKEN_LABEL --pin $PIN --so-pin $PIN
          pkcs11-tool --module $MODULE_PATH --keygen --key-type aes:32 --pin $PIN --token-label $TOKEN_LABEL --label kleidi-kms-plugin

          softhsm2-util --show-slots

          ls -al /var/lib/softhsm/tokens
      command:
      - /bin/sh
      - -c
      volumeMounts:
      - mountPath: /var/lib/softhsm/tokens
        name: softhsm-tokens
      - mountPath: /opt/softhsm/
        name: softhsm-config
        readOnly: true
  {{- end }}
  containers:
    - name: kleidi-kms-plugin
      image: {{ .Values.deployment.kleidiKmsPlugin.registry | default .Values.global.registry }}/{{ .Values.deployment.kleidiKmsPlugin.image }}:{{ .Values.deployment.kleidiKmsPlugin.tag }}
      imagePullPolicy: {{ .Values.global.imagePullPolicy }}
      args:
      {{- if .Values.global.softHsm }}
        - -provider=softhsm
        - -configfile=/opt/softhsm/config.json
      {{- else }}
        - -provider=hvault
        - -configfile=/opt/kleidi/config.json
      {{- end }}
        - -listen={{ .Values.deployment.kleidiKmsPlugin.kleidiSock }}
      {{- if .Values.debug }}
        - -debugmode=true
      {{- end }}
      {{- with .Values.resources }}
      resources:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      env:
      {{- if .Values.tls.enabled }}
        - name: "VAULT_CACERT"
          value: "/opt/kleidi/tls/vault-ca.pem"
      {{- end }}
      {{- with .Values.deployment.kleidiKmsPlugin.extraEnv }}
        {{- toYaml . | nindent 8 }}
      {{- end }}
      volumeMounts:
        - name: token
          mountPath: /var/run/secrets/kubernetes.io/serviceaccount/
        - name: sock
          mountPath: /tmp/kleidi
        {{- if .Values.global.softHsm }}
        - name: softhsm-config
          mountPath: /opt/softhsm/
          readOnly: true
        - name: softhsm-tokens
          mountPath: /var/lib/softhsm/tokens
        {{- else }}
        - name: config
          mountPath: /opt/kleidi
          readOnly: true
        {{- end }}
        {{- if .Values.tls.enabled }}
        - name: tls-config
          mountPath: /opt/kleidi/tls
          readOnly: true
        {{- end }}
        {{- with .Values.extraVolumeMounts }}
        {{- toYaml . | nindent 8 }}
        {{- end }}
      {{- with .Values.containerSecurityContext }}
      securityContext:
        {{- toYaml . | nindent 8 }}
      {{- end }}
  volumes:
    - name: token
      projected:
        sources:
        - serviceAccountToken:
            path: token
            expirationSeconds: 7200
            audience: vault
    - name: sock
      hostPath:
        path: /tmp/kleidi
        type: DirectoryOrCreate
    {{- if .Values.global.softHsm }}
    - name: softhsm-tokens
      hostPath:
        path: /var/lib/softhsm/tokens
        type: DirectoryOrCreate
    - name: softhsm-config
      configMap:
        name: "{{ template "kleidi.fullname" . }}-init-config"
    {{- else }}
    - name: config
      configMap:
        name: "{{ template "kleidi.fullname" . }}-config"
    {{- end }}
    {{- if .Values.tls.enabled }}
    - name: tls-config
      secret:
        secretName: {{ .Values.tls.secretName }}
        items:
        - key: {{ .Values.tls.keyName }}
          path: vault-ca.pem
    {{- end }}
    {{- with .Values.extraVolumes }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  {{- with .Values.affinity }}
  affinity:
  {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.tolerations }}
  tolerations:
  {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}
