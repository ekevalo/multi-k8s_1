docker build -t ekevalo/multi-client:latest -t ekevalo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ekevalo/multi-server:latest -t ekevalo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ekevalo/multi-worker:latest -t ekevalo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ekevalo/multi-client:latest
docker push ekevalo/multi-server:latest
docker push ekevalo/multi-worker:latest

docker push ekevalo/multi-client:$SHA
docker push ekevalo/multi-server:$SHA
docker push ekevalo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ekevalo/multi-server:$SHA
kubectl set image deployments/client-deployment client=ekevalo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ekevalo/multi-worker:$SHA