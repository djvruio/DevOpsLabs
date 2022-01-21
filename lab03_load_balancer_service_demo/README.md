# Lab 03: Demo for Load Balancer Service
This lab uses:
1. Cluster created in [Lab 01](../lab01_create_K8s_cluster/README.md)
2. The Kubernetes command-line tool, ```kubectl```
3. Visual Studio Code (Run as a Administrator)
4. File ```load-balancer-service.yaml``` [here](../lab03_load_balancer_service_demo/load-balancer-service.yaml)

# What is does
1. Implement a Deployment Object with a LoadBalancer service
2. Show LoadBalancer info
3. Delete the Service
4. Delete the deployment


# Commands used
- ```kubectl apply -f load-balancer-service.yaml```
- ```kubectl get service```
- ```kubectl describe service <name-service>```
- Delete Service
    - ```kubectl get service -o wide```
    - ```kubectl delete svc <service-name>```
- Delete Deployment
    - ```kubectl get deploy -A```
    - ```kubectl delete deploy <deploy-name> -n <namespace>```
