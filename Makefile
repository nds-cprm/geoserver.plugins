#
# Set variables to pass
#

name_it = "geoserver.plugins"

ports = 8080:8088

uuid_it = $(shell uuid | sed -e 's/-//;' | cut -b 1-12 )

image_tag = cprm.nds:$(name_it).refer

docker_file = Dockerfile.$(name_it)

docker_env = $(name_it).env

docker_name = $(name_it).$(uuid_it)

#
# make what to make
#

auto-up: build up 

up:

	docker run -rm -d $(image_tag) --name $(docker_name) -p $(ports) --env-file $(docker_env) bash 

start:
	
	docker container start $(docker_name)

stop:
	
	docker container stop $(docker_name)

clean:

	docker container rm $(docker_name) 

build:

	docker build -t $(image_tag) -f $(docker_file) . 

razed:

	docker image rm $(image_tag)

wait:

	sleep 5

logs:

	docker logs $(docker_name)

#smoketest: up
#	docker-compose exec --noinput --nocapture --detailed-errors --verbosity=1 --failfast
#
#unittest: up

reset: stop wait start

hardreset: stop clean razed build up 


