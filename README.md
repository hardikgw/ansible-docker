## examples for ansible using docke rimages

### simple:

- starts three containers (one with ansible, two webservers)
- creates links between ansible and web containers
- creates playbook to check connections

#### steps
  - git clone
  - docker-compose up -d
  - docker exec ansible ansible-playbook automate.yml
