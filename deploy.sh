docker build -t jlxc106/multi-client:latest -t jlxc106/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jlxc106/multi-server:latest -t jlxc106/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t jlxc106/multi-worker:latest -t jlxc106/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push jlxc106/multi-client:latest
docker push jlxc106/multi-server:latest
docker push jlxc106/multi-worker:latest

docker push jlxc106/multi-client:$SHA
docker push jlxc106/multi-server:$SHA
docker push jlxc106/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jlxc106/multi-server:$SHA
kubectl set image deployments/client-deployment client=jlxc106/multi-client:$SHA
kubectl set iamge deployments/worker-deployment worker=jlxc106/multi-worker:$SHA