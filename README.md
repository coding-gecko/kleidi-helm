# kleidi-helm
Helm Chart for Kleidi: https://github.com/beezy-dev/kleidi/
# Prerequisites
- K8S version 1.27 or higher (for KMS v2 API to be available)
- Helm 3
# Deployment
Chart offers two deployment modes: deploys DaemonSet or Deployment. By default, DaemonSet is enabled.
## Configuration
See values.yaml what can be configured.
## Installing the chart with Helm
Assuming you've downloaded the chart into folder named 'kleidi' and filled out 'kleidi-values.yaml':
```bash
$ helm install kleidi kleidi/ -n kube-system -f kleidi-values.yaml
```

## Uninstalling the chart
```bash
$ helm uninstall kleidi -n kube-system
```
