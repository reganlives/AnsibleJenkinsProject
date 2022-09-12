# AnsibleJenkinsProject
Ansible and Jenkins Project

clone the repo in the link

EITHER spin up 1 VM and install Jenkins locally (no need for inventory and hostname is 'localhost' in playbook.yaml)

if local 'ansible-playbook -v playbook.yaml

if remote, 'ansible-playbook -v -i inventory.yaml playbook.yaml

If configuring remote VM, remember in inventory to change ansible_user and key name (also key chmod)

in the playbook, change JDK-8-jre to jdk-11-jre

get the initial admin password from the console output

################################
Exercise:
1.use a t2.micro with access to port 8080 and 22

2.access the server and install ansible on it (if not sure, use docs)

3.see the ansible-playbook posted earlier in the call and run -ansible-playbook -v playbook.yaml'

4.navigate to your jenkins server, enter the initial admin password (the last playbook task output displayed on terminal)

5.ensure you have a github repo ready

6.enter project URL

7.tick Poll SCM and hook trigger for SCM Polling

8.indicate Jenkinsfile with url of github project and branch 'main'

9.hit 'save'

10.on github, set up webhook with 'http://<your_ip>:8080/github-webhook/

11.leave it as 'just push the event' and save

12.on jenkins pipeline project, hit 'build now'