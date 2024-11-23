FROM ollama/ollama:0.4.1

# Listen on all interfaces, port 8080
ENV OLLAMA_HOST 0.0.0.0:8080

# Store model weight files in /models
# https://github.com/ollama/ollama/blob/main/docs/faq.md#where-are-models-stored
ENV OLLAMA_MODELS /root/.ollama/models

# Reduce logging verbosity
ENV OLLAMA_DEBUG false

# Never unload model weights from the GPU
ENV OLLAMA_KEEP_ALIVE -1 

# Store the model weights in the container image
RUN ollama serve & sleep 5 && ollama pull llama3.2-vision 
RUN ollama serve & sleep 5 && ollama pull gemma2:9b 
#RUN ollama serve & sleep 5 && ollama pull qwen2.5-coder:32b

# Start Ollama
ENTRYPOINT ["ollama", "serve"]