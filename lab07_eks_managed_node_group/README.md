# Lab 07: Demo Managed Nodegroup

# What is does
This lab demonstrate how to update K8s version for Control Plane and Data Plane

# Why? Because ..
1. K8s version needs to be updated
2. Deploy security Patches
3. EC2 AMI need to be updated (patching/rehydratation), etc..

Advantages with Managed NodeGroup

1. Application not will be down
2. Not have to orchestrate HA
3. Not create AMI, etc
4. AWS create and manages EC2 workers for you
5. Autoscaling group is using behind the scenes, etc.
6. Managed Nodegroup is free of charge

# Commands used
- ```eksctl create cluster --name demoeks --version 1.19 --nodegroup-name demoeks-nodes --node-type t3.micro --nodes 4 --managed``` (wait 10 min.)
- ```kubectl get all```
- ```kubectl apply -f nginx-deployment.yaml```
- ```kubectl get all```
- Accces to AWS EKS console for Update the K8s version for Control Plane
![Diagram](../diagrams/generated_png_diagrams/lab-07-control-plane.png)
- Accces to AWS EKS console for Update the AMI version for Data Plane (Node Group)
![Diagram](../diagrams/generated_png_diagrams/lab-07-data-plane.png)
![Diagram](../diagrams/generated_png_diagrams/lab-07-autoscaling-group.png)
Alternative command for update the Node Group
- ```kubectl upgrade nodegroup --name=managed-ng-1 --cluster=managed-cluster```
- ```kubectl get nodes``` see the initial status
- ```kubectl get pods``` 
- ```kubectl get nodes```
- Delete the cluster
- ```eksctl get cluster --region=us-east-1```
- ```eksctl delete cluster --name=max-pod-test --region=us-east-1```
- ```eksctl get cluster --region=us-east-1```