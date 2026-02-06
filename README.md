# AKS with ArgoCD and Crossplane

## ArgoCD Config

<p> To debug the helm chart: </p>

```bash
    helm template nginx-app ./charts/nginx-web --debug
```

<p> To create app by cli </p>

```bash
    argocd app create nginx-web \
    --project default \
    --repo Your repo .git
    --path charts/nginx-web
    --dest-server https://kubernetes.default.svc \
    --dest-namespace nginx-web \
    --sync-policy automated \
    --self-heal \
    --auto-prune \
    --sync-option CreateNamespace=true
```
