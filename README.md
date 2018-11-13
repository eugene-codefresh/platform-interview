# Overview

This API is responsible for responding with the name of the environment it is running inside of.

#### Test

```
curl http://localhost:8080
```

### Compilation

I took tomcat:8.5-alpine docker image and further actions would be using this image.
To compile Api.java I need to copy servlet-api.jar into `jre/lib/ext/` directory: 
```
sudo docker cp <container_id>:/usr/lib/jvm/java-1.8-openjdk/jre/lib/ext/servlet-api.jar /usr/lib/jvm/java-8-oracle/jre/lib/ext`
```
then
```
cd src/main/webapp/WEB-INF
src/main/webapp/WEB-INF$ javac -d . ../../java/com/vividseats/servlet/Api.java
```
The compiled class is located under the next path now:
```
src/main/webapp/WEB-INF/com/vividseats/servlet/Api.class
```

### Build docker image with Dockerfile 
```
docker build -t eugenecodefresh/interview:1.0 .
```
and push to docker image registry:
```
docker push eugenecodefresh/interview:1.0
```

### Testing the image

Run the customized image with the following command:
```
docker run -it --rm -p 8080:8080 -e ENVIRONMENT="production" eugenecodefresh/interview:1.0
```

In browser type `http://localhost:8080`


### Terraform

How to run :
* go into terraform directory
```
cd terraform
```
* create secrets.tfvars file the next variables:
```
aws_access_key = "your-access-key"
aws_secret_key = "your-secret-key"
```
* go through other variables and change them as needed
* Init terraform 
```
terraform init
```
* Apply your resource configuration
```
terraform apply -var-file="secrets.tfvars"
```