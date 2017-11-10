# ansible-via-docker-poc

## Summary

A proof-of-concept, or plethera of crap, for running Ansible via a Docker container. Well, mostly. This is an idea for running Ansible Playbooks consistently across development and build environments for Windows/macOS/Linux.


## Dependencies

A few obvious dependencies. 

  - Docker >=17.9.*, configured on the host machine for Linux containers
  - PowerShell, for the build script; [OS distributions](https://github.com/PowerShell/PowerShell#get-powershell)
  - [Docker Hub](https://hub.docker.com/r/williamyeh/ansible/) access, for William Yeh's [docker-ansible image](https://github.com/William-Yeh/docker-ansible)


## Usage

Run `./build.ps1` to run a generic build. This will build Docker prerequisites. Afterward, it will execute the Docker container, mounting your local directory to `/ansible/playbooks`, which will run Ansible against them.
