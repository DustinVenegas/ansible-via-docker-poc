# ansible-via-docker-poc

## Summary

A proof-of-concept, or plethera of crap, for running Ansible via a Docker container. Well, mostly. This is an idea for running Ansible Playbooks consistently across development and build environments for Windows/macOS/Linux.


## Prerequisites

A few obvious dependencies. 

**Machine**

  - SSH Keys, specified or located in ~/.ssh/
  - Docker >=17.9.*, configured on the host machine for Linux containers
  - PowerShell, for the build script; [OS distributions](https://github.com/PowerShell/PowerShell#get-powershell)
  - [Docker Hub](https://hub.docker.com/r/williamyeh/ansible/) access, for William Yeh's [docker-ansible image](https://github.com/William-Yeh/docker-ansible)

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

### Default Build

Builds Docker machines locally then executes the Ansible Container with the current directory mounted to `/ansible/playbooks` for execution.

```
./build.ps1
```


### Execute Ansible, Manually

Directly execute Ansible commands against a Container.

```
<# Build the docker images #>
docker build -t myLocalName ./infrastructure/

<# Run Ansible, mounting your own volumes/settings/etc #>
docker run --rm myLocalName:latest /usr/bin/ansible --version
```

