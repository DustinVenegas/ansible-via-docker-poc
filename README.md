= ansible-via-docker-poc

== Summary

A proof-of-concept, or plethera of crap, for running Ansible via a Docker container. Well, mostly. This is an idea for running Ansible Playbooks consistently across development and build environments for Windows/macOS/Linux.


== Dependencies

A few obvious dependencies. 

  - Docker >=17.9.*, configured on the host machine for Linux containers
  - PowerShell, for the build script; [OS distributions](https://github.com/PowerShell/PowerShell#get-powershell)
  - [Docker Hub](https://hub.docker.com/r/williamyeh/ansible/) access, for William Yeh's [docker-ansible image](https://github.com/William-Yeh/docker-ansible)


== Usage

Run `./build.ps1` to run a generic build. This will build Docker prerequisites. Afterward, it will execute the Docker container, mounting your local directory to `/ansible/playbooks`, which will run Ansible against them.


== TODO

  - **Enable SSH keys:** Consider using Docker's `--link` parameter to share the keys. It might look similar to `Host Keys -> Integration Test Container -> Ansible Container`.
  - **Ansible Arguments:** For quickly iterating with Ansible, extend build.ps1 to take dynamic parameters for Ansible
  - **Ansible Defaults:** Consider using [a pass-thru wrapper](https://github.com/William-Yeh/docker-ansible/blob/master/ubuntu16.04-onbuild/ansible-playbook-wrapper) for Ansible on the Ansible container.
  - **Line Endings:** CRLF functions on Windows to Docker currently. Determine if lf-only is necessary, or highly recommended.
