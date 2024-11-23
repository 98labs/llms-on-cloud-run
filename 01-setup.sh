# Set the Project ID
export PROJECT_ID="duet-ai-98labs-demos"

# Create cloud storage bucket
# https://cloud.google.com/storage/docs/creating-buckets#command-line
gcloud storage buckets create gs://ollama-server --project=$PROJECT_ID --default-storage-class=STANDARD --location=asia-southeast1 --uniform-bucket-level-access

# Create a dedicated service account
gcloud iam service-accounts create ollama \
  --display-name="Service Account for Ollama Cloud Run service"

# Grant Storage Admin role to ollama Service Account
# https://cloud.google.com/iam/docs/manage-access-service-accounts
gcloud iam service-accounts add-iam-policy-binding ollama@duet-ai-98labs-demos.iam.gserviceaccount.com \
    --member=user:username@example.com --role=roles/storage.admin

# Create an Artifact Registry Docker Repository
gcloud artifacts repositories create ollama-server-repo \
  --repository-format=docker \
  --location=asia-southeast1