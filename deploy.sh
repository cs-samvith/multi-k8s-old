docker build -t samvidocker/multi-client:latest -t samvidocker/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t samvidocker/multi-server:latest -t samvidocker/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t samvidocker/multi-worker:latest -t samvidocker/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker
docker push samvidocker/multi-client:latest
docker push samvidocker/multi-server:latest
docker push samvidocker/multi-worker:latest

docker push samvidocker/multi-client:$SHA
docker push samvidocker/multi-server:$SHA
docker push samvidocker/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=samvidocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=samvidocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=samvidocker/multi-worker:$SHA

