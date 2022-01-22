# Lab 06: Demo Pod Limit according to EC2 instance type

# What is does
This lab demonstrate that the max number of allowed Pods depends on EC2 instance Type
    - t3.micro instance permits maximun 4 pods
[Reference](https://github.com/awslabs/amazon-eks-ami/blob/master/files/eni-max-pods.txt)

1. Create a cluster with ```eksctl``` 
2. Create Pods that exceeds EC2 instance limits
3. Play with the cluster and review pod created and pending (FailedScheduling)
4. Delete the cluster

# Commands used
- ```eksctl create cluster --name max-pod-test --version 1.19 --node-type t3.micro --nodes 2 --region us-east-1``` (wait 10 min.)
- Alternative command if the targeted availability zone, does not currently have sufficient capacity to support the cluster: ```eksctl create cluster --name max-pod-test --version 1.19 --node-type t3.micro --nodes 2 --region us-east-1 --zones us-east-1c,us-east-1d,us-east-1f```
- ```kubectl get ns```
- ```kubectl get pods -n kube-system```
- ```kubectl apply -f nginx-deployment.yaml```
- ```kubectl get all```
- Then update replicas from 1 to 10 in nginx-deployment.yaml
    - Run again ```kubectl apply -f nginx-deployment.yaml```
- ```kubectl get pods``` see Status: Running, ContainerCreating, Pending
- ```kubectl describe pod <name-pod>```
- Delete the cluster
    - ```eksctl get cluster --region=us-east-1```
    - ```eksctl delete cluster --name=max-pod-test --region=us-east-1```
    - ```eksctl get cluster --region=us-east-1```