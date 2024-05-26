# Mario on AWS EKS with Terraform
> :warning: **AWS EKS clusters cost $0.10 per hour**, so you may incur charges by running this tutorial.

## 1. 📝 Preparation
- Follow [installations](https://github.com/veben/aws_terraform_snippets/blob/main/readme.md)
- Choose **Cloud hosting** and follow the different steps
- Install kubectl. For that, you can follow [the official guide](https://kubernetes.io/docs/tasks/tools/)

## 2. 🪂 Deploying EKS cluster
```sh
cd tf/
terraform init; terraform plan; terraform apply --auto-approve
```
- Configure kubectl to access to the k8s cluster
```sh
aws eks --profile p_lambda_deployer --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)
```
- Verify the cluster
```sh
kubectl cluster-info
```
- Verify the worker nodes
```sh
kubectl get nodes
```
## 3. 🚀 Deploying the game
- Deploy the `deployment` and the `service`
```sh
cd ../k8s_mario
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```
- Verify the existence of the different components
```sh
kubectl get all
```

## 4. 🧪 Test the game
- Recover the LoadBalancer Ingress URL
```sh
kubectl describe service mario-service
```
- Copy/paste the URL in a browser

## 5. 🚿 Cleaning
- Destroy the `deployment` and the `service`
```sh
kubectl delete service mario-service
kubectl delete deployment mario-deployment
```
- Destroy the EKS cluster
```sh
cd ../tf
terraform destroy --auto-approve
```