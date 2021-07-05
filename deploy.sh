#!/usr/bin/env bash

echo "Detecting SSH Bastion Tunnel/Proxy"
if [[ ! "$(pgrep -f L8888:127.0.0.1:8888)" ]]; then
  echo "Did not detect a running SSH tunnel.  Opening a new one."
  
  gcloud beta compute ssh --zone "us-central1-a" "array-poc-cluster-bastion"  --project "gke-terraform-mamta" -- -L8888:127.0.0.1:8888 -f tail -f /dev/null &
  sleep 30
  echo "SSH Tunnel/Proxy is now running."
else
  echo "Detected a running SSH tunnel.  Skipping."
fi


# Set the HTTPS_PROXY env var to allow kubectl to bounce through
# the bastion host over the locally forwarded port 8888.
export HTTPS_PROXY=localhost:8888
echo $HTTPS_PROXY

echo 'Deploying Manifests'
HTTPS_PROXY=localhost:8888 kubectl apply -f "manifests/."

# # Make sure it is running successfully.
echo 'Waiting for rollout to complete and pod available.'
kubectl rollout status --timeout=5m deployment/nginx
