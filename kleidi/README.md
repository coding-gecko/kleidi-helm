# kleidi

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![AppVersion: v1.0.0-c2](https://img.shields.io/badge/AppVersion-v1.0.0--c2-informational?style=flat-square)

kleidi KMS provider plugin for Kubernetes

**Homepage:** <https://github.com/beezy-dev/kleidi/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Gergo Mocsi | <gmocsi@redhat.com> |  |

## Source Code

* <https://github.com/beezy-dev/kleidi/>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | Affinity settings, defaults added. | Affinity. Used both in Deployment and DaemonSet. |
| annotations | object | `{}` | Annotations. Used both in Deployment and DaemonSet. |
| containerSecurityContext | object | `{"allowPrivilegeEscalation":true}` | The security context for containers. Used both in Deployment and DaemonSet. |
| daemonset.enabled | bool | `true` | Deploys kleidi as DaemonSet.If this enabled, set "deployment.enabled" to false. |
| daemonset.updateStrategy | object | `{"type":"RollingUpdate"}` | Update Strategy for DaemonSet. |
| debug | bool | `false` | Enable debug mode |
| deployment.enabled | bool | `false` | Deploys kleidi as deployment. If this enabled, set "daemonset.enabled" to false. |
| deployment.kleidiKmsInit.config.path | string | `"/usr/lib64/softhsm/libsofthsm.so"` | Library to use for HSM inside init container. |
| deployment.kleidiKmsInit.config.pin | string | `"1234"` | HSM pin for init container. |
| deployment.kleidiKmsInit.config.tokenLabel | string | `"kleidi-kms-plugin"` | Token label for init container. Can be same as container name. |
| deployment.kleidiKmsInit.image | string | `"beezy-dev/kleidi-kms-init"` | Image name for init container. |
| deployment.kleidiKmsInit.registry | string | `nil` | Override global registry for init container. |
| deployment.kleidiKmsInit.tag | string | `"hsm-b5f665d"` | Tag for init container. |
| deployment.kleidiKmsPlugin.config.address | string | `"http://127.0.0.1:8200"` | Address of Vault. |
| deployment.kleidiKmsPlugin.config.namespace | string | `""` | Vault Enterprise namespace. |
| deployment.kleidiKmsPlugin.config.transitkey | string | `"kleidi"` | Name of Transit Key used in Vault. |
| deployment.kleidiKmsPlugin.config.vaultrole | string | `"kleidi"` | Role name in Vault. |
| deployment.kleidiKmsPlugin.extraEnv | list | `[]` | Extra environment values for KMS plugin container. |
| deployment.kleidiKmsPlugin.image | string | `"beezy-dev/kleidi-kms-plugin"` | Image name for KMS plugin container. |
| deployment.kleidiKmsPlugin.kleidiSock | string | `"unix:///tmp/kleidi/kleidi-kms-plugin.sock"` | Socket for kleidi to listen on. |
| deployment.kleidiKmsPlugin.registry | string | `nil` | Override global for KMS plugin container. |
| deployment.kleidiKmsPlugin.tag | string | `"vault-b5f665d"` | Image tag for KMS plugin container. |
| deployment.replicaCount | int | `1` | Replica count for pods. |
| deployment.strategy | object | `{"type":"RollingUpdate"}` | Update strategy. |
| extraVolumeMounts | object | `{}` | Extra volume mounts if needed. Used both in Deployment and DaemonSet. |
| extraVolumes | object | `{}` | Extra volumes if needed. Used both in Deployment and DaemonSet. |
| global.imagePullPolicy | string | `"Always"` | Global image pull policy.   |
| global.namespace | string | `"kube-system"` | Namespace should stay kube-system. |
| global.registry | string | `"ghcr.io"` | Registry to fetch images from. Can be locally overwritten. |
| global.softHsm | bool | `false` | Determines the use of SoftHSM provider. If set to true, SoftHSM is deployed instead of Vault provider. |
| hostAliases | object | `{}` | Host aliases. Used both in Deployment and DaemonSet. |
| hostNetwork | bool | `true` | Use host network. Used both in Deployment and DaemonSet. |
| nodeSelector | object | `{}` | NodeSelector(s). Used both in Deployment and DaemonSet. |
| podSecurityContext | object | `{"fsGroup":0,"runAsGroup":0,"runAsUser":0}` | The security context for pods. Used both in Deployment and DaemonSet. |
| priorityClassName | string | `"system-cluster-critical"` | Name of the PriorityClass. Used both in Deployment and DaemonSet. |
| rbac.annotations | object | `{}` | Annotations for Role Bindings. |
| rbac.create | bool | `true` | Create role bindings. Should be set to true. |
| rbac.keepRB | bool | `false` | Preserves Role Bindings after "helm uninstall". It adds annotation "helm.sh/resource-policy: "keep"". Role Bindings survive "helm uninstall". |
| resources | object | `{"limits":{"cpu":"300m","memory":"256Mi"}}` | Resource requests and limits. Used both in Deployment and DaemonSet. |
| serviceAccount.annotations | object | `{}` | annotations for ServiceAccount. |
| serviceAccount.create | bool | `true` | Enables/disables the creation of ServiceAccount. |
| serviceAccount.imagePullSecrets | list | `[]` | ImagePullSecrets for ServiceAccount. |
| serviceAccount.keepSA | bool | `true` | Preserves ServiceAccount after "helm uninstall". It adds annotation "helm.sh/resource-policy: "keep"". ServiceAccount survives "helm uninstall". |
| serviceAccount.name | string | `"kleidi-vault-auth"` | Name of the ServiceAccount. |
| tls.enabled | bool | `false` | Enables/Disables TLS between Kleidi and Vault |
| tls.keyName | string | `"cafile"` | Key name inside secret. |
| tls.secretName | string | `"vault-ca"` | Vault CA chain secret name - you need to create it manually. Secret should be present in the same namespace as Kleidi. |
| tolerations | list | Toleration settings, defaults added. | Tolerations. Used both in Deployment and DaemonSet. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
