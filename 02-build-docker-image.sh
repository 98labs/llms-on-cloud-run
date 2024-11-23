# Set the Project ID
export PROJECT_ID="duet-ai-98labs-demos"
export REPO_NAME="ollama-server-repo"
export DOCKER_IMAGE="ollama-server"
export LOCATION="asia-southeast1"

# Build the container image using Cloud Build
gcloud builds submit \
   --tag $LOCATION-docker.pkg.dev/$PROJECT_ID/$REPO_NAME/$DOCKER_IMAGE \
   --machine-type e2-highcpu-32
