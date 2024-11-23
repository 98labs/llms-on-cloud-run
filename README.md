# llms-on-cloud-run

This repository includes the following scripts
* environment setup on GCP
* build docker image
* deploy docker container

Connect using the `curl command`
```
curl https://ollama-server-671820338183.asia-southeast1.run.app/api/generate -d '{
  "model": "llama3.2-vision",
  "prompt": "Why is the sky blue?",
  "stream": false
}'
```

Connect using `ollama`
```
# install ollama locally
brew install ollama # mac

# connect to an ollama server
# use model: llama3.2-vision (if available)
OLLAMA_HOST=https://ollama-server-671820338183.asia-southeast1.run.app/ ollama run llama3.2-vision

# use model: gemma2:9b (if available)
OLLAMA_HOST=https://ollama-server-671820338183.asia-southeast1.run.app/ ollama run gemma2:9b

# use model: qwen2.5-coder:32b (if available)
OLLAMA_HOST=https://ollama-server-671820338183.asia-southeast1.run.app/ ollama run qwen2.5-coder:32b
```

Bonus! Use open-webui to connect to ollama server
```
# Pull docker image for open-webui
docker pull ghcr.io/open-webui/open-webui:main

# Create an Artifact Registry Docker Repository
gcloud artifacts repositories create open-webui-repo \
  --repository-format=docker \
  --location=asia-southeast1

# Tag the image for Google Container Registry
docker tag ghcr.io/open-webui/open-webui:main asia-southeast1-docker.pkg.dev/duet-ai-98labs-demos/open-webui-repo/open-webui:main

# Push to Google Container Registry
docker push asia-southeast1-docker.pkg.dev/duet-ai-98labs-demos/open-webui-repo/open-webui:main

# Deploy open-webui
gcloud beta run deploy open-webui \
  --image asia-southeast1-docker.pkg.dev/duet-ai-98labs-demos/open-webui-repo/open-webui:main \
  --set-env-vars WEBUI_AUTH=False \
  --set-env-vars OLLAMA_BASE_URL=https://ollama-server-671820338183.asia-southeast1.run.app \
  --concurrency 50 \
  --cpu 2 --memory 4Gi \
  --max-instances 5 \
  --allow-unauthenticated \
  --no-cpu-throttling \
  --timeout=1200 \
  --session-affinity \
  --add-volume name=in-memory-1,type=in-memory,size-limit=2G \
  --add-volume-mount volume=in-memory-1,mount-path=/app/backend/data
```