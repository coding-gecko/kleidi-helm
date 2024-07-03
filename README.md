# kleidi-helm
Helm Chart for Kleidi: https://github.com/beezy-dev/kleidi/
# Prerequisites
- K8S version 1.27 or higher (for KMS v2 API to be available)
- Helm 3
# Deployment
Chart offers two deployment modes: deploys DaemonSet or Deployment. By default, DaemonSet is enabled.</br>
You can deploy Kleidi with tor without TLS. For TLS, you need to configure Vault to listen on HTTPS, and obtain the Root CA Cert for that HTTPS endpoint.
## Configuration
See kleidi/README.md about what can be configured.</br>
**Note:** it is strongly recommended to install Kleidi into "kube-system".
## Installing Helm chart - TLS disabled
Assuming you've downloaded the chart into folder named 'kleidi' and filled out 'kleidi-values.yaml':
```bash
$ helm install kleidi kleidi/ -n kube-system -f kleidi-values.yaml
```
## Installing Helm chart - TLS enabled
First you need to create a secret containing Vault Root CA cert before you install the chart with Helm. 
For this example, let's assume it is called 'vault-ca.pem' and you've downloaded it into '/tmp/vault-certs.pem'.
Create the secret in the following way (called "vault-ca" in this example with key name "cafile"):
```bash
$ kubectl create secret generic --namespace kube-system vault-ca --from-file=cafile=/tmp/vault-certs.pem
```
**Note: the key name is important!!**</br>

Now modify tls section in your kleidi-values.yaml:
```yaml
tls:
  enable: true
  secretName: vault-ca # change it to yours
  keyName: cafile # change it to yours
```

Assuming you've filled out the rest of 'kleidi-values.yaml', you can install Kleidi:
```bash
$ helm install kleidi kleidi/ -n kube-system -f kleidi-values.yaml
```

## Uninstalling the chart
```bash
$ helm uninstall kleidi -n kube-system
```
**Note:** if you've set any of the following parameters to true, those won't be removed by Helm: "rbac.keepRB", "serviceAccount.keepSA" . </br>
Do not forget, that the TLS secret you've created outside Helm, it won't be also removed.
