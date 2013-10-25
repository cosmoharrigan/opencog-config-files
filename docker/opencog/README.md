
Install Docker from https://www.docker.io/gettingstarted/

```
sudo docker build -t $USER/opencog .
CONTAINER_ID=$(sudo docker run -d $USER/opencog)
echo $(sudo docker logs $CONTAINER_ID | sed -n 1p)
sudo docker ps
docker inspect $CONTAINER_ID | grep IPAddress | cut -d '"' -f 4
sudo docker port $CONTAINER_ID 22
ssh docker@127.17.0.147 -p 49153
```
