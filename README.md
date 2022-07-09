# AWS K8s PERN Stack Application 

## Description

This application uses the technological PERN Stack, has a React application that serves as a client, a REST API built with Expres.js and is connected to a Postgres DB. It uses AWS services like EKS, RDS, EC2, CloudWatch, NLB and has a secure network with private subnets to host important services.

![Architecture Diagram](/k8s-terraform.png?raw=true "Architecture Diagram")

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

## Setup

After performing the Terraform Apply, we have to run the following command so that kubeconfig obtains the access configuration to the cluster that we deployed we must to include the name of the cluster and the default region.

`aws eks update-kubeconfig --name eks-cluster-pern --region us-east-1`

To verify if we are into the cluster, we can run:

`kubectl get svc`

The only service that has to be running is the cluster.

### Install ArgoCD 

We are going to use ArgoCD to handle the automatic deployments of our application, for this we have to use the following commands:

Create the argocd namespace

`kubectl create namespace argocd`

Install the manifest

`kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml`

We have to do a port forwarding to our localhost to be able to access the ArgoCD UI

`kubectl port-forward -n argocd svc/argocd-server 8080:443`

Now, we can access to the UI in the http://localhost:8080, after this we have to obtain the password of the administrator user using the following commands

`kubectl get secret argocd-initial-admin-secret -n argocd -o yaml`

`echo [password obtained in the yaml file] | base64 --decode`

Then, we have to create a new app and point to the repository of our Kubernetes application. ArgoCD will take care of making the deployment correctly in the namespace that we indicate.

### Nginx Ingress Controller and NLB deployment

The last component of our application is the Nginx Ingress Controller, this will be in charge of exposing our application through a Network Load Balancer in a public subnet, we do this by running the following command:

`kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.2.1/deploy/static/provider/aws/deploy.yaml`

After the creation of the NLB is finished, we can access the application through the DNS provided by the resource.

## 🚀 Quick reference

•	Maintained by: Byron Murillo

•	Where go to get help: https://github.com/vairome/k8s-terraform/issues

## License

[MIT](https://choosealicense.com/licenses/mit/)

