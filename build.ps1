param(
    [switch]$syntaxCheck
)

# Build the docker image
$dockerImageName = 'dustinvenegas/ansible-via-docker-poc'
Push-Location "$PSScriptRoot/infrastructure"
docker build -t $dockerImageName .
Pop-Location

# Gather Docker arguments
$dockerArgs = @()
$dockerArgs += 'run'
$dockerArgs += '--rm' # Automatically remove the container (after running)
$dockerArgs += "-v${pwd}:/ansible/playbooks" # mounts the current directory to /ansible/playbooks
$dockerArgs += "$dockerImageName:latest" # The container built above

# Append ansible arguments
$dockerArgs += '/usr/bin/ansible-playbook' # Run Ansible installed from base image
$dockerArgs += "--inventory=inventory.ini" # Use the volume mounted inventory
if ($syntaxCheck) {
    $dockerArgs += '--syntax-check' # Removes the image on disk after running
}
$dockerArgs += "playbook.yml" # Use the volume mounted playbook
$dockerArgs += "--connection=local" # Connect to self (until docker-compose)
$dockerArgs += "-vvvv" # All the verbosities

Write-Verbose "Docker args are: $dockerArgs"

# Run the Docker image built above aginst the arguments
docker $dockerArgs
