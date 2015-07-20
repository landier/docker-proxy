# docker-proxy

docker run -v /usr/share/elasticsearch/data --name es-data busybox /bin/true

docker run -d -p 9200:9200 -p 9300:9300 --volumes-from es-data --name es elasticsearch

docker build -t proxy .
docker run --rm --link=es -p 3128:3128 --name proxy proxy

docker exec -it proxy /bin/bash

docker run -d -p 5601:5601 --link es:elasticsearch --name kibana kibana
