# K8s PERN Stack Application 

This application uses the technological PERN Stack, has a React application that serves as a client, a REST API built with Expres.js and is connected to a Postgres DB. It uses AWS services like EKS, RDS, EC2, CloudWatch, NLB and has a secure network with private subnets to host important services.

## How it works

It is a REST API to store tasks through 3 fields, id, task and done, which is a boolean data type to handle the status of tasks.

All HTTP requests work through a lambda, there is a lambda for each type of request, get, post, put and delete, in the same way there are 4 endpoints for each type of HTTP request.

Additionally, they have an X-Ray trace configured that points to a group of CloudWatch logs.


## How to deploy this infrastructure in your own AWS account

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

