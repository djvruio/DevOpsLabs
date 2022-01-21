# Lab 04: Demo for NodePort Service
This lab uses:
1. Cluster created in [Lab 01](../lab01_create_K8s_cluster/README.md)
2. The Kubernetes command-line tool, ```kubectl```
3. Visual Studio Code (Run as a Administrator)
4. File ```nodeport-service.yaml``` [here](../lab04_node_port_service_demo/nodeport-service.yaml)

# What is does
1. Implement a Deployment Object with a NodePort service
2. Show NodePort Service info
3. Delete the deployment


# Commands used
- ```kubectl apply -f nodeport-service.yaml```
- ```kubectl get all```
- ```kubectl get services```
- ```kubectl get pods``` (shows one pod)
- ```kubectl get pods -o wide```
- Delete Deployment
    - ```kubectl get deploy -A```
    - ```kubectl delete deploy <deploy-name> -n <namespace>```
