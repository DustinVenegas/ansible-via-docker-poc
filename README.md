# ansible-via-docker-poc

## Summary

A proof-of-concept, or plethera of crap, for running Ansible via a Docker container. Well, mostly. This is an idea for running Ansible Playbooks consistently across development and build environments for Windows/macOS/Linux.


## Prerequisites

A few obvious dependencies. 

  - Docker >=17.9.*, configured on the host machine for Linux containers
  - PowerShell, for the build script; [OS distributions](https://github.com/PowerShell/PowerShell#get-powershell)
  - [Docker Hub](https://hub.docker.com/r/williamyeh/ansible/) access, for William Yeh's [docker-ansible image](https://github.com/William-Yeh/docker-ansible)


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

