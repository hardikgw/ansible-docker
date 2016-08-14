## examples for ansible using docker

### simple setup:

- starts three containers (one with ansible, two webservers)
- creates links between ansible and web containers
- creates playbook to check connections

#### Setup
  - `git clone`
  - `docker-compose up -d`
  - `docker exec web1 /usr/sbin/sshd`
  - `docker exec web2 /usr/sbin/sshd`
  - `docker exec mysql /usr/sbin/sshd`
  - `docker exec ansible ansible-playbook automate.yml`

### Cleanup
  - `docker stop ansible web1 web2`
  - `docker rm ansible web1 web2`
  - `docker rmi $(docker images -q simple_*)`

### Dependencies
  - docker-compose assumes the following images
