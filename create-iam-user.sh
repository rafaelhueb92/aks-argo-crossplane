echo "🧑‍💼 Creating IAM User"

aws iam create-user --user-name crossplane-lab-user

echo "🔑 Creating Access Key for crossplane-lab-user"

aws iam create-access-key --user-name crossplane-lab-user > aws-credentials.json

echo "📃 Attaching policy for user"

aws iam attach-user-policy \
  --user-name crossplane-lab-user \
  --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

echo "⚙️ Config Credentials"

ACCESS_KEY_ID=$(jq -r '.AccessKey.AccessKeyId' aws-credentials.json)
SECRET_ACCESS_KEY=$(jq -r '.AccessKey.SecretAccessKey' aws-credentials.json)

cat > aws-credentials.txt <<EOF
[default]
aws_access_key_id = $ACCESS_KEY_ID
aws_secret_access_key = $SECRET_ACCESS_KEY
EOF

echo "✓ Credentials formatted with success!"

echo "📦 Creating secret"

kubectl create secret generic aws-creds \
  -n crossplane-system \
  --from-file=creds=./aws-credentials.txt