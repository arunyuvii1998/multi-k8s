docker build -t arun98/multi-client:latest -t arun98/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arun98/multi-server:latest -t arun98/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t arun98/multi-worker:latest -t arun98/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push arun98/multi-client:latest
docker push arun98/multi-server:latest
docker push arun98/multi-worker:latest

docker push arun98/multi-client:$SHA
docker push arun98/multi-server:$SHA
docker push arun98/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployment/server-deployment server=arun98/multi-server:$SHA
kubectl set image deployment/client-deployment client=arun98/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=arun98/multi-worker:$SHA