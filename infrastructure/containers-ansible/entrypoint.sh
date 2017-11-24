#!/bin/sh
#
# Simple ansible-playbook wrapper with requirements handling and .ssh key staging
# 
# USAGE:
#    entrypoint.sh  [executable] [other arguments]
#
# ENVIRONMENT VARIABLES:
#
#    - REQUIREMENTS: requirements filename; default = "requirements.yml"
#    - STAGING_SSHKEYS: folder containing ssh keys; default = "/ansible/staging/.ssh"

# ENV:STAGING_SSHKEYS
if [ -z "$STAGING_SSHKEYS" ]; then
    STAGING_SSHKEYS=/ansible/staging/.ssh
fi

if [ -e "$STAGING_SSHKEYS" ]; then
    # SSH key staging
    #   Copy keys from staging to /root/.ssh/ with appropriate permissions.
    #
    #   Staging is not required. Linux hosts can use a Docker Volume to mount ~/.ssh/ to /root/.ssh. 
    #   This exists for Windows/macOS users which may require resetting volume file permissions.

    # Ensure the destination exists first
    mkdir -p /root/.ssh

    # Copy all the files, which we'll assume are all keys
    cp --recursive --target-directory=/root/.ssh/ $STAGING_SSHKEYS/.

    # Required permissions for SSH. The *.pub keys could be 644, but that shouldn't be necessary
    chmod 600 ~/.ssh/*
fi

# ENV:REQUIREMENTS
if [ -z "$REQUIREMENTS" ]; then
    REQUIREMENTS=requirements.yml
fi

# If the file exists, then install them
if [ -f "$REQUIREMENTS" ]; then
    apt-get install -y git
    ansible-galaxy install -r $REQUIREMENTS
fi

# Default execution
exec /usr/bin/ansible-playbook "$@"
