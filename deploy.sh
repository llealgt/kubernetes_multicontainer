docker build -t wichofer89/multi-client:latest -t wichofer89/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t wichofer89/multi-server:latest -t wichofer89/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t wichofer89/multi-worker:latest -t wichofer89/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push wichofer89/multi-client:latest
docker push wichofer89/multi-server:latest
docker push wichofer89/multi-worker:latest

docker push wichofer89/multi-client:$GIT_SHA
docker push wichofer89/multi-server:$GIT_SHA
docker push wichofer89/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=wichofer89/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=wichofer89/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=wichofer89/multi-worker:$GIT_SHA