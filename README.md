# ansible-via-docker-poc

## Summary

A proof-of-concept, or plethera of crap, for running Ansible via a Docker container. 

## Description

This repository demonstrates running an Ansible playbook inside a Docker container.

This might be useful in scenarios where you want to share a consistent Ansible playbook execution environment. 

Playbooks run against a single configured environment regardless of the host operating system. This may be useful for sharing an environment across developers, environments, integration tests, etc. It also makes a fun cross-platform demo.

Docker volumes are used to share the repository's Ansible playbook and host runtime dependencies, such as SSH keys.

## Prerequisites

A few obvious dependencies. 

**Machine**

  - SSH Keys for Ansible, specified or located in `~/.ssh/ansible_docker_id_rsa` and `~/.ssh/ansible_docker_id_rsa.pub`
  - docker >=17.9.*, configured on the host machine for Linux containers
  - docker-compose >=1.16

### ansible_docker_id_rsa SSH Key

This enviornment expects the following SSH keys to exist in the host machine 

  - `~/.ssh/ansible_docker_id_rsa`: Used by the Ansible container for outgoing connections
  - `~/.ssh/ansible_docker_id_rsa.pub`: Used by the Target container as the `~/.ssh/authorized_keys` file for accepting connections

The non-standard location prevents exposing default host credentials to containers. Since the keys are specalized, we can set them to be psaswordless for localhost testing.

Below demonstrates creating passwordless, generic, SSH Keys into `~/.ssh/ansible_docker_id_rsa` and `~/.ssh/ansible_docker_id_rsa.pub`.

```
# Using Linux or a VM?
ssh-keygen -t rsa -b 4096 -C "ansible-host-key for docker" -q -N "" -f ~/.ssh/ansible_docker_id_rsa

# Using Windows Subsystem for Linux?
#   Remember that `~` in WSL isn't your Windows home directory!
#   The file output parameter, `-f`, should be specified as /mnt/C/Users/<username>/.ssh/ansible_docker_id_rsa
ssh-keygen -t rsa -b 4096 -C "ansible-host-key for docker" -q -N "" -f /mnt/c/Users/<username>/.ssh/ansible_docker_id_rsa
```


## Usage

### Run

Build and run an Ansible host and SSHD target container. The SSH keys are copied to each container for connections. The current working directory is a volume mounted to `/ansible/playbooks` for execution.

```
./build.sh

# PowerShell
./build.ps1
```

