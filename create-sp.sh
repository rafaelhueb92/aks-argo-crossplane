EXISTS=$(az ad sp list --display-name crossplane-lab-sp -o tsv | wc -l | xargs)

if [ $EXISTS -eq "0" ]; then
    echo "🆕 Creating new RBAC"
    az ad sp create-for-rbac --name crossplane-lab-sp \
    --role Contributor \
    --scopes //subscritptions/$(az account show --query id -o tsv) \
    > azure-credentials.json
fi

APP_ID=$(jq -r '.appId' azure-credentials.json)
TENANT_ID=$(jq -r '.tenant' azure-credentials.json)
SUBSCRIPTION_ID=$(az account show --query id -o tsv)
CLIENT_ID=$(jq -r '.password' azure-credentials.json)

cat > azure-credentials.json <<EOF
{
    "clientId":"$APP_ID",
    "clientSecret":"$CLIENT_ID",
    "subscriptionId":"$SUBSCRIPTION_ID",
    "tenantId":"$TENANT_ID"
}
EOF

kubectl create secret generic azure-creds \
-n crossplane-system \
--from-file=creds=./azure-credentials.json

# To get info az ad sp list --display-name crossplane-lab-sp -o table