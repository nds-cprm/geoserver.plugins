#
# Set variables to pass
#

name_it = geoserver.plugins

ports = -p 8087:8080

image_tag = cprm.nds:$(name_it)2refer

docker_file = Dockerfile.$(name_it)

docker_env = $(name_it).env

container_name = $(name_it)4refer

#
# make what to make
#

auto-up: up 

up: 

	docker run --init --detach --name $(container_name) --env-file $(docker_env) $(ports) $(image_tag) $(use) 

start: 
	
	docker container start $(container_name)

stop: 
	
	docker container stop $(container_name)

clean: stop

	docker container rm $(container_name) 

build:

	docker build --rm -t $(image_tag) -f $(docker_file) .

razed:

	docker image rm $(image_tag)

wait:

	sleep 5

logs:

	docker logs $(container_name)

#smoketest: up
#
#	docker-compose exec --noinput --nocapture --detailed-errors --verbosity=1 --failfast
#
#unittest: up

reset: stop wait start

hardreset: stop clean razed build up 


