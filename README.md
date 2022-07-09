# AWS K8s PERN Stack Application 

## Description

This application uses the technological PERN Stack, has a React application that serves as a client, a REST API built with Expres.js and is connected to a Postgres DB. It uses AWS services like EKS, RDS, EC2, CloudWatch, NLB and has a secure network with private subnets to host important services.

## Setup

aws eks update-kubeconfig --name eks-cluster-pern --region us-east-1
kubectl get svc
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl port-forward -n argocd svc/argocd-server 8080:443
kubectl get secret argocd-initial-admin-secret -n argocd -o yaml
echo LWIwRml1UlN4Vi02VWRRZQ== | base64 --decode
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.2.1/deploy/static/provider/aws/deploy.yaml
kubectl create secret generic pgpassword --from-literal PGPASSWORD=password --namespace=pern-app

## Usage

Clone the repo, and have installed the AWS CLI and Terraform in your local machine, the credentials are passed by the profile of your aws cli configuration.

Then...

1)Inicialize terraform.
```js
terraform init

```
2) Review the terraform plan
```js
terraform plan
```

3) Deploy the infraestructure
```js
terraform apply
```

## 🚀 Quick reference

•	Maintained by: Byron Murillo

•	Where go to get help: https://github.com/vairome/k8s-terraform/issues

## License

[MIT](https://choosealicense.com/licenses/mit/)

