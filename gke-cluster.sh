#!/bin/bash

# This will dinamically set the project ID to the current project you are logged in
PROJECT_ID=$(gcloud config get-value project)
CLUSET_NAME="cluster-1"
REGION="us-central1"
KUBERNETES_VERSION="1.33.0-gke.2248000"

# Generate a basic cluster
gcloud beta container \
  --project $PROJECT_ID clusters create $CLUSET_NAME \
  --region ${REGION} \
  --no-enable-basic-auth \
  --cluster-version $KUBERNETES_VERSION \
  --release-channel "regular" \
  --machine-type "n2d-standard-2" \
  --image-type "COS_CONTAINERD" \
  --disk-type "pd-balanced" \
  --disk-size "30" \
  --metadata disable-legacy-endpoints=true \
  --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
  --spot \
  --num-nodes "2" \
  --logging=SYSTEM,WORKLOAD \
  --monitoring=SYSTEM \
  --enable-ip-alias \
  --network "projects/${PROJECT_ID}/global/networks/default" \
  --subnetwork "projects/${PROJECT_ID}/regions/${REGION}/subnetworks/default" \
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