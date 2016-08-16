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

#### Container names / host names
  - web1 (weblogic)
  - web2 (weblogic)
  - mysql (mysql + python) - db port 3306
  - ansible (ansible + python)

#### URLs
  - Web1 (weblogic) : http://localhost:8101/console/
  - Web2 (weblogic) : http://localhost:8201/console/

#### SSH
  - web1 (weblogic) : -p 3122
  - web2 (weblogic) : -p 3222
  - mysql (mysql)   : -p 3333

### Cleanup
  - `docker stop ansible web1 web2`
  - `docker rm ansible web1 web2`
  - `docker rmi $(docker images -q simple_*)`

### Dependencies
  - docker-compose assumes the following images
    - oracle/weblogic with domain -t 1213-domain
  - other network download will occur as below
    - mysql
    - ubuntu updates
    - ansible
