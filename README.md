# postgresql-client
Postgresql client for init containers in Kubernetes

# Wait for a database to be ready with init containers
In Kubernetes if your service depends on a database, it is a good idea to check that the database is ready before spinning up the service. This is particularly important when there is an upgrade or a node change in Kubernetes where services can spin up faster than the database. 

```yaml
```
