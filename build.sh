aws ecr get-login-password --region eu-west-3 | docker login --username AWS --password-stdin 791327379439.dkr.ecr.eu-west-3.amazonaws.com/boris-parsing
aws ecr get-login-password --region eu-west-3 | docker login --username AWS --password-stdin public.ecr.aws/o1b1c4o6/laravel-docker

docker build --cache-from public.ecr.aws/o1b1c4o6/laravel-docker:latest \
	-f 7.3/Dockerfile \
	-t public.ecr.aws/o1b1c4o6/laravel-docker:latest .

docker push public.ecr.aws/o1b1c4o6/laravel-docker:latest


aws ecr get-login-password --region eu-west-3 | docker login --username AWS --password-stdin public.ecr.aws/o1b1c4o6


docker push public.ecr.aws/o1b1c4o6/laravel-docker:latest

docker login repo.shrd.fr:5050

docker build -t repo.shrd.fr:5050/sapiendo/sapiendo_laravel:latest .


docker push repo.shrd.fr:5050/sapiendo/sapiendo_laravel:latest
