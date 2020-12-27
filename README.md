# Ansible playbook runner

A simple action that runs `ansible-playbook` with provided arguments.

## Inputs

### arguments

**Required**. At least, you should set the playbook file name there. Do not use quotes, because they are parsed incorrectly.

### ssh_key

A private ssh key. It is usually stored in repository secrets. Not required, can be set via arguments.

### config

If is set, there will be created a custom config file with the input content. Useful when you don't want to store a separated file in the repository.

### inventory

If is set, there will be created a file with the input content. Useful when you don't want to store a separated file in the repository. Also can be set via `-i` or `--inventory` argument.


### password

A vault password, usually is stored in repository secrets. Also can be set via arguments and the file in repository itself, but this does not make sense.

## A complete github action example

**./github/workflows/my_deploy_action.yml**

```yml
---
# Deploys my app via ansible playbook

name: Deploy my application

on:
  push:
    branches:
      - 'master'

jobs:

  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout the repository
        uses: actions/checkout@v2

      - name: Run playbook
        uses: jokernakartama/ansible-playbook-action@latest
        with:

          arguments: |
            playbook.yml
            --user siteadmin

          inventory: |
            [web]
            mysite.com
            [db]
            db.mysite.com
            [all:vars]
            app_name=myapp

          config: |
            [defaults]
            deprecation_warnings = False

          ssh_key: ${{secrets.SSH_KEY}}

```
