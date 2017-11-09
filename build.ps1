# Build the docker image
Push-Location "$PSScriptRoot/infrastructure"
docker build -t dustinvenegas/ansible-personal .
Pop-Location

# Run docker against the repository
#  `--rm` Removes the image on disk after running 
#  `-v ${pwd}/playbooks` mounts the current directory to /playbooks
#  `/usr/bin/ansible-playbook` is the ansible installation location
docker run --rm -v ${pwd}:/playbooks dustinvenegas/ansible-personal:latest /usr/bin/ansible-playbook --help

