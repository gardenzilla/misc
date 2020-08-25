#!/bin/bash
BASEDIR=/home/peter/Documents/projects/gardenzilla
SERVICES=("client" "api" "user" "email")

for service in ${SERVICES[@]}; do
    service_name=$service"_microservice"
    if [ "$service" = "api" ]; then
        service_name="api"
    fi
    if [ "$service" = "client" ]; then
        service_name="client"
    fi
    # Stop service container
    docker stop $service_name || true
    # Remove service container
    docker rm $service_name || true
    # Run service
    docker run -d \
        --network="host" \
        -v $BASEDIR/data/${service}_space:/usr/local/bin/data \
        --name $service_name \
        --env-file ./ENV.list \
        --log-driver none \
        --restart always \
        $service_name
done
