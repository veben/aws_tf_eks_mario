# Mario on AWS EKS with Terraform
> :warning: **AWS EKS clusters cost $0.10 per hour**, so you may incur charges by running this tutorial.

## 1. ⚙ Prerequisites
- Follow [installations](https://github.com/veben/aws_terraform_snippets/blob/main/readme.md)
- Choose **Cloud hosting** and follow the different steps
- Install kubectl. For that, you can follow [the official guide](https://kubernetes.io/docs/tasks/tools/)

## 2. 📝 Preparation
To tailor your cluster according to your requirements, create a `terraform.tfvars` file. The two most crucial variables to customize are the **region** where you want to deploy the infrastructure and the AWS **profile** that you previously defined, ensuring it has the necessary permissions.
```plaintext
region  = "eu-west-1"
profile = "p-dev"
```
If you omit variables in this file, the default values from `variables.tf` will be applied automatically.

## 3. 🪂 Deploying EKS cluster
```sh
terraform init; terraform plan; terraform apply --auto-approve
```
- Configure kubectl to access to the k8s cluster
```sh
aws eks --profile p-dev --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
```
- Verify the cluster
```sh
kubectl cluster-info
```
- Verify the worker nodes
```sh
kubectl get nodes
```
## 4. 🚀 Deploying the game
- Deploy the `deployment` and the `service`
```sh
kubectl apply -f k8s_mario/deployment.yaml
kubectl apply -f k8s_mario/service.yaml
```
- Verify the existence of the different components
```sh
kubectl get all
```

## 5. 🧪 Testing the game
- Recover the LoadBalancer Ingress URL
```sh
kubectl describe service mario-service
```
- Copy/paste the URL in a browser

## 6. 🚿 Cleaning
- Destroy the `deployment` and the `service`
```sh
kubectl delete service mario-service
kubectl delete deployment mario-deployment
```
- Destroy the EKS cluster
```sh
terraform destroy --auto-approve
```