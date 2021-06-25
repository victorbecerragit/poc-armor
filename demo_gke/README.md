Configure kubectl

```
gcloud container clusters get-credentials $(terraform output -raw kubernetes_cluster_name) --region $(terraform output -raw region)
```
GKE nodes and node pool
```
gcloud container clusters describe dos-terraform-edu-gke --region us-central1 --format='default(locations)'
```

