# Basics of Kubernetes

## Creating a Google Kuberenetes Cluster
1. install Google Cloud SDK [installation guide](https://cloud.google.com/sdk/docs/install)
2. After installation run `gcloud init`
3. Select your project
4. With you can create a cluster, with the following command(in this directory): `./gke-cluster.sh`

If you are facing error Project does not exist, run `gcloud config set project <project_id>`.
If still facing error, edit the `gke-cluster.sh` file and change the `PROJECT_ID` variable to your project ID.