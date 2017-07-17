#!/bin/sh

#docker exec mq service ssh start
docker exec web1 service ssh start
docker exec web2 service ssh start


#docker cp ansible_hosts ansible:/etc/ansible/hosts
#docker cp ping.yml ansible:/ping.yml

docker cp . ansible:/.
docker exec ansible ansible-playbook listener.yml