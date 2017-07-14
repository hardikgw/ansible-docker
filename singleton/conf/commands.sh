docker exec mq apt-get update
docker exec mq apt-get install -y openssh-server
docker exec mq service ssh start


docker cp ansible_hosts ansible:/etc/ansible/hosts
docker cp ping.yml ansible:/ping.yml

docker exec ansible ansible-playbook ping.yml