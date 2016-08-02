## examples for ansible using docker

### simple:

- starts three containers (one with ansible, two webservers)
- creates links between ansible and web containers
- creates playbook to check connections

#### steps
  - git clone
  - docker-compose up -d
  - docker exec ansible ansible-playbook automate.yml

### cleanup
  - docker stop ansible web1 web2
  - docker rm ansible web1 web2
  - docker rmi $(docker images -q simple_*)
