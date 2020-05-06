docker build -t reguero/multi-client:latest -t reguero/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t reguero/multi-server:latest -t reguero/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t reguero/multi-worker:latest -t reguero/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push reguero/multi-client:latest
docker push reguero/multi-server:latest
docker push reguero/multi-worker:latest

docker push reguero/multi-client:$SHA
docker push reguero/multi-server:$SHA
docker push reguero/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=reguero/multi-server:$SHA
kubectl set image deployments/client-deployment server=reguero/multi-client:$SHA
kubectl set image deployments/worker-deployment server=reguero/multi-worker:$SHA
