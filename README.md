[![Docker Pulls](https://img.shields.io/docker/pulls/gushcloud/postgresql-client?style=for-the-badge)](https://hub.docker.com/r/gushcloud/postgresql-client)
![GitHub Workflow Status (event)](https://img.shields.io/github/workflow/status/gushai-platform/postgresql-client/CI-build?label=Github%20Actions%20Build&style=for-the-badge)

# postgresql-client
Postgresql client for init containers in Kubernetes<br />
<br />
Dockerhub: https://hub.docker.com/r/gushcloud/postgresql-client
```shell
docker pull gushcloud/postgresql-client:latest
```
<br />

# Kubernetes wait for a database to be ready with init containers
In Kubernetes, if your app depends on a database, it is a good idea to check that the database is ready before spinning up the application. This can be done using init containers which fires off before containers start to run. The init containers need to complete before containers can start. This is particularly important when there is an upgrade or a node change in Kubernetes where services can spin up faster than the database. <br /><br />

# Example deployment yaml
Sleep for 2 seconds and try again until database service is running. 
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app
spec:
  replicas: 3
  template:
    metadata:
      labels:
        app: app
    spec:
      initContainers:
        - name: check-db-ready
          image: gushcloud/postgresql-client:latest
          command: ['sh', '-c', 'until pg_isready -h postgresql-service -p 5432; do echo waiting for database; sleep 2; done;']
      containers:
        - image: busybox
          name: busybox
          ports:
          - containerPort: 3000
          env:
          - name: postgresql_host
            value: postgresql-service
          - name: postgresql_port
            value: "5432"
          - name: postgresql_user
            valueFrom:
              secretKeyRef:
                name: database-secret
                key: user
          - name: postgresql_database
            valueFrom:
              secretKeyRef:
                name: database-secret
                key: database
          - name: postgresql_password
            valueFrom:
              secretKeyRef:
                name: database-secret
                key: password
```
