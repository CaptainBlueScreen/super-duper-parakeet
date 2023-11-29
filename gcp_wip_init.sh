# update with your project 
export PROJECT_ID="my-project"
export SERVICE_ACCOUNT_NAME="service-account-name"
export IDENTITY_POOL_ID="identity-pool-id"
export IDENTITY_POOL_NAME="identity pool name"
export IDENTITY_PROVIDER_ID="identity-provider-id"
export IDENTITY_PROVIDER_NAME="identity provider name"
export REPO="username/repo_name"

# Enable IAM Credentials API
gcloud services enable iamcredentials.googleapis.com \
  --project "${PROJECT_ID}"

# Create GCP service account
gcloud iam service-accounts create "${SERVICE_ACCOUNT_NAME}" \
  --project "${PROJECT_ID}"

# Create workload identity pool
gcloud iam workload-identity-pools create "${IDENTITY_POOL_ID}" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --display-name="${IDENTITY_POOL_NAME}"

# Get the workload identity pool ID
export WORKLOAD_IDENTITY_POOL_ID=gcloud iam \
  workload-identity-pools describe "${IDENTITY_POOL_ID}" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --format="value(name)"

# Create workload identity provider
gcloud iam workload-identity-pools providers create-oidc "${IDENTITY_PROVIDER_ID}" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --workload-identity-pool="${IDENTITY_POOL_ID}" \
  --display-name=${IDENTITY_PROVIDER_NAME} \
  --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository" \
  --issuer-uri="https://token.actions.githubusercontent.com"

# Allow auth from provider and repo to service account
gcloud iam service-accounts add-iam-policy-binding "${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" \
  --project="${PROJECT_ID}" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/${WORKLOAD_IDENTITY_POOL_ID}/attribute.repository/${REPO}"

# Get the Workload Identity Provider resource name
gcloud iam workload-identity-pools providers describe ${IDENTITY_PROVIDER_ID} \
  --project="${PROJECT_ID}" \
  --location="global" \
  --workload-identity-pool="${IDENTITY_POOL_ID}" \
  --format="value(name)"
