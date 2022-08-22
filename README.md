# AnsibleJenkinsProject
Ansible and Jenkins Project

clone the repo in the link

EITHER spin up 1 VM and install Jenkins locally (no need for inventory and hostname is 'localhost' in playbook.yaml)

if local 'ansible-playbook -v playbook.yaml

if remote, 'ansible-playbook -v -i inventory.yaml playbook.yaml

If configuring remote VM, remember in inventory to change ansible_user and key name (also key chmod)

in the playbook, change JDK-8-jre to jdk-11-jre

get the initial admin password from the console output