#!/bin/bash

# This will dinamically set the project ID to the current project you are logged in
PROJECT_ID=$(gcloud config get-value project)
CLUSET_NAME="intern-cluster"
REGION="us-east1"
KUBERNETES_VERSION="1.32.4-gke.1106006"
NETWORK="default"
SUBNEWORK="default"

# Generate a basic cluster
gcloud beta container \
  --project $PROJECT_ID clusters create $CLUSET_NAME \
  --region ${REGION} \
  --no-enable-basic-auth \
  --cluster-version $KUBERNETES_VERSION \
  --release-channel "regular" \
  --machine-type "e2-medium" --spot --num-nodes "1" --image-type "COS_CONTAINERD" --node-locations "${REGION}-c" \
  --disk-type "pd-standard" --disk-size "40" \
  --enable-autoscaling --total-min-nodes "0" --total-max-nodes "2" --location-policy "BALANCED" \
  --metadata disable-legacy-endpoints=true \
  --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
  --logging=SYSTEM,WORKLOAD \
  --monitoring=SYSTEM \
  --enable-ip-alias \
  --network "projects/${PROJECT_ID}/global/networks/${NETWORK}" \
  --subnetwork "projects/${PROJECT_ID}/regions/${REGION}/subnetworks/${SUBNEWORK}" \
  --no-enable-intra-node-visibility \
  --default-max-pods-per-node "110" \
  --enable-ip-access \
  --security-posture=standard \
  --workload-vulnerability-scanning=disabled \
  --enable-dataplane-v2 \
  --no-enable-master-authorized-networks \
  --addons HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver \
  --enable-autoupgrade \
  --enable-autorepair \
  --max-surge-upgrade 1 \
  --max-unavailable-upgrade 0 \
  --enable-shielded-nodes \
  --binauthz-evaluation-mode=DISABLED \
  --shielded-integrity-monitoring \
  --shielded-secure-boot