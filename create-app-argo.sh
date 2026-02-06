argocd app create nginx-web \
--project default \
--repo https://github.com/rafaelhueb92/aks-argo-crossplane.git \
--path charts/nginx-web \
--dest-server https://kubernetes.default.svc \
--dest-namespace nginx-web \
--sync-policy automated \
--self-heal \
--auto-prune \
--sync-option CreateNamespace=true