az ad sp create-for-rbac --name crossplane-lab-sp \
--role Contributor \
--scopes //subscritptions/$(az account show --query id -o tsv) \
> azure-credentials.json

APP_ID=$(jq -r '.appID' azure-credentials.json)
TENANT_ID=$(jq -r '.tenant' azure-credentials.json)
SUBSCRIPTION_ID=$(az account show --query id -o tsv)
CLIENT_ID=$(jq -r '.password' azure-credentials.json)

cat > azure-credentials <<EOF
{
    "clientId:"$APP_ID",
    "clientSecret:"$CLIENT_ID",
    "subscriptionId":"$SUBSCRIPTION_ID",
    "tenantId":"$TENANT_ID"
}
EOF