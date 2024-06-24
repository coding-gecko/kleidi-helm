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
| affinity | object | Affinity settings | Affinity. Used both in Deployment and DaemonSet. affinity: {} |
| annotations | object | `{}` | Annotations. Used both in Deployment and DaemonSet. |
| containerSecurityContext | object | `{"allowPrivilegeEscalation":true}` | The security context for containers. Used both in Deployment and DaemonSet. |
| daemonset | object | DaemonSet settings. | Deploy Kleidi as DaemonSet. |
| daemonset.enabled | bool | `true` | Deploys kleidi as DaemonSet.If this enabled, set "deployment.enabled" to false. |
| daemonset.updateStrategy | object | `{"type":"RollingUpdate"}` | Update Strategy for DaemonSet. |
| debug | bool | `false` | Enable debug mode |
| deployment | object | Deployment settings | Deploy Kleidi as Deployment. It also includes the container configurations, these are used regardless Deployment or DaemonSet is selected. |
| deployment.enabled | bool | `false` | Deploys kleidi as deployment. If this enabled, set "daemonset.enabled" to false. |
| deployment.kleidiKmsInit | object | `{"config":{"path":"/usr/lib64/softhsm/libsofthsm.so","pin":"1234","tokenLabel":"kleidi-kms-plugin"},"image":"beezy-dev/kleidi-kms-init","registry":null,"tag":"softhsm-b5f665d"}` | Values related to kleidi-kms-init container. |
| deployment.kleidiKmsInit.config | object | `{"path":"/usr/lib64/softhsm/libsofthsm.so","pin":"1234","tokenLabel":"kleidi-kms-plugin"}` | Configurations for softhsm init container. |
| deployment.kleidiKmsInit.config.path | string | `"/usr/lib64/softhsm/libsofthsm.so"` | Library to use for HSM. |
| deployment.kleidiKmsInit.config.pin | string | `"1234"` | HSM pin. |
| deployment.kleidiKmsInit.config.tokenLabel | string | `"kleidi-kms-plugin"` | Token Label. Can be same as container name. |
| deployment.kleidiKmsInit.image | string | `"beezy-dev/kleidi-kms-init"` | Image name. |
| deployment.kleidiKmsInit.registry | string | `nil` | Override global registry. |
| deployment.kleidiKmsInit.tag | string | `"softhsm-b5f665d"` | Tag for the image. |
| deployment.kleidiKmsPlugin.config | object | `{"address":"http://127.0.0.1:8200","namespace":"","transitkey":"kleidi","vaultrole":"kleidi"}` | Config for kleidi-kms-plugin. It's converted into JSON and placed into ConfigMap. |
| deployment.kleidiKmsPlugin.config.address | string | `"http://127.0.0.1:8200"` | Address of Vault. |
| deployment.kleidiKmsPlugin.config.namespace | string | `""` | Vault Enterprise namespace. |
| deployment.kleidiKmsPlugin.config.transitkey | string | `"kleidi"` | Name of Transit Key used in Vault. |
| deployment.kleidiKmsPlugin.config.vaultrole | string | `"kleidi"` | Role name in Vault. |
| deployment.kleidiKmsPlugin.image | string | `"beezy-dev/kleidi-kms-plugin"` | Image name. |
| deployment.kleidiKmsPlugin.kleidiSock | string | `"unix:///tmp/kleidi/kleidi-kms-plugin.sock"` | Socket for kleidi to listen on. |
| deployment.kleidiKmsPlugin.registry | string | `nil` | Override global registry. |
| deployment.kleidiKmsPlugin.tag | string | `"vault-b5f665d"` | Tag for the image. |
| deployment.replicaCount | int | `1` | Replica count for pods. |
| extraVolumeMounts | object | `{}` | Extra volume mounts if needed. Used both in Deployment and DaemonSet. |
| extraVolumes | object | `{}` | Extra volumes if needed. Used both in Deployment and DaemonSet. |
| global | object | Global settings | Global section, settings common for Deployment and DaemonSet options. |
| global.imagePullPolicy | string | `"Always"` | Global image pull policy.   |
| global.namespace | string | `"kube-system"` | Namespace should stay kube-system. |
| global.registry | string | `"ghcr.io"` | Registry to fetch images from. Can be locally overwritten. |
| global.softHsm | bool | `false` | Determines if use softHSM provider or not. If disabled, vault is selected, the init container for Kleidi is not deployed. |
| hostAliases | object | `{}` | Host aliases. Used both in Deployment and DaemonSet. |
| hostNetwork | bool | `true` | Use host network. Used both in Deployment and DaemonSet. |
| nodeSelector | object | `{}` | NodeSelector(s). Used both in Deployment and DaemonSet. |
| podSecurityContext | object | `{"fsGroup":0,"runAsGroup":0,"runAsUser":0}` | The security context for pods. Used both in Deployment and DaemonSet. |
| priorityClassName | string | `"system-cluster-critical"` | Name of the PriorityClass. Used both in Deployment and DaemonSet. |
| rbac | object | RBAC settings | Create role bindings. Used both in Deployment and DaemonSet. |
| rbac.annotations | object | `{}` | Annotations for Role Bindings. |
| rbac.create | bool | `true` | Create role bindings. Should be set to true. |
| rbac.keepRB | bool | `false` | Preserves Role Bindings after "helm uninstall". It adds annotation "helm.sh/resource-policy: "keep"". Role Bindings survive "helm uninstall". |
| resources | object | `{"limits":{"cpu":"300m","memory":"256Mi"}}` | Resource requests and limits. Used both in Deployment and DaemonSet. |
| serviceAccount | object | ServiceAccount settings. | serviceAccount setting. Used both in Deployment and DaemonSet. |
| serviceAccount.create | bool | `true` | Enables/disables the creation of ServiceAccount. |
| serviceAccount.keepSA | bool | `true` | Preserves ServiceAccount after "helm uninstall". It adds annotation "helm.sh/resource-policy: "keep"". ServiceAccount survives "helm uninstall". |
| serviceAccount.name | string | `"kleidi-vault-auth"` | Name of the ServiceAccount. |
| tolerations | list | Toleration settings | Tolerations. Used both in Deployment and DaemonSet. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.13.1](https://github.com/norwoodj/helm-docs/releases/v1.13.1)
