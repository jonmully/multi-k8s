docker build -t mullerj/multi-client:latest -t mullerj/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mullerj/multi-server:latest -t mullerj/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mullerj/multi-worker:latest -t mullerj/multi-worker:$SHA -f ./worder/Dockerfile ./worker
docker push mullerj/multi-client:latest
docker push mullerj/multi-server:latest
docker push mullerj/multi-worker:latest
docker push mullerj/multi-client:$SHA
docker push mullerj/multi-server:$SHA
docker push mullerj/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mullerj/multi-server:$SHA
kubectl set image deployments/client-deployment client=mullerj/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mullerj/multi-worker:$SHA