docker build -t alexioan87/multi-client:latest -t alexioan87/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alexioan87/multi-server:latest -t alexioan87/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alexioan87/multi-worker:latest -t alexioan87/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alexioan87/multi-client:latest
docker push alexioan87/multi-server:latest
docker push alexioan87/multi-worker:latest

docker push alexioan87/multi-client:$SHA
docker push alexioan87/multi-server:$SHA
docker push alexioan87/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alexioan87/multi-server:$SHA
kubectl set image deployments/client-deployment client=alexioan87/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alexioan87/multi-worker:$SHA