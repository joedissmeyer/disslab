# Ansible playbook for deploying the Elastic Stack

Install requirements

```
ansible-galaxy install -r .roles/requirements.yml
```

Run the playbook

```
ansible-playbook -i inventory/prod deploy-elastic-stack.yml
```
