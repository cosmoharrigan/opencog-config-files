
Install Docker from https://www.docker.io/gettingstarted/

Adjust apt sources in Dockerfile to match your local mirror

```
build -t $USER/opencog .
CONTAINER_ID=$(sudo docker run -d -p 17001:17001 $USER/opencog)
CONTAINER_IP=$(sudo docker inspect $CONTAINER_ID | grep IPAddress | cut -d '"' -f 4)
sudo docker logs $CONTAINER_ID | sed -n 1p
ssh docker@$CONTAINER_IP
```
