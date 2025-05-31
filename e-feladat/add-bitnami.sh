#!/bin/bash

set -e

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm upgrade --install wordpress bitnami/wordpress \
  --namespace wordpress \
  -f wp_values.yaml