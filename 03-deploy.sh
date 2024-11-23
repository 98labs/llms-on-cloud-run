# Deploy the ollama-server service to Cloud Run (with Cloud Storage volume mounted)
gcloud beta run deploy ollama-server \
  --image asia-southeast1-docker.pkg.dev/duet-ai-98labs-demos/ollama-server-repo/ollama-server \
  --concurrency 3 \
  --cpu 8 --memory 32Gi \
  --set-env-vars OLLAMA_NUM_PARALLEL=3 \
  --set-env-vars OLLAMA_MODELS=/root/.ollama/models \
  --gpu 1 --gpu-type nvidia-l4 \
  --max-instances 3 \
  --allow-unauthenticated \
  --no-cpu-throttling \
  --service-account ollama@duet-ai-98labs-demos.iam.gserviceaccount.com \
  --timeout=3600 \
  --add-volume name=cloud-storage-1,type=cloud-storage,bucket=ollama-server \
  --add-volume-mount volume=cloud-storage-1,mount-path=/root/.ollama 