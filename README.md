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

######################################
Exercise:
SSH onto the instance install docker engine and then run 'sudo apt install docker-compose -y'

login as jenkins user and install pip/pip dependencies - ## sudo su - jenkins

fork the github link provided - you'll need to put a new webhook in that

then use that forked project's URL in the pipeline configuration

sudo docker system prune -a -f
python3 -m pytest ./prime/tests/test_unit.py
sudo docker-compose build
for example, if you have a 'module not found' error, install it. If not, remove the library/module declaration from the .py file
pip install <module_name>
python3 -m pip install <module_name>
you'll need to log into the specific user's account to access them
also install docker-compose 'sudo apt install docker-compose -y'

#########
configure your pipeline
ensure your webhook is st up
create a Jenkinsfile from the template provided and then adapt it to reflect stages such as 'build' and 'test' (using the command lines provided earlier in the chat)
try just doing sudo docker-compose build first - just to get that first successful build
then try adding the tests and pushing your code

pip install pytest
pip install flask_testing

#####################################################################################################

1. spin up a t2.medium/t2.small 
2. ssh onto instance and install Ansible and Docker/Docker-Compose 
3. ansible-playbook to config and install Jenkins
4. setup using init admin passwd 
5. config pipeline
   a. provide URL for reference
   b. indicate 'hook trigger for SCM' and 'poll SCM' (leave blank)
   c. indicate Jenkinsfile from repo as pipeline script
   d. provide URL and branch(es) to build to - ensure you indicate git as SCM!!!
   e. create and provide credential
   f. save
--------------------------
6. ensure our local repo includes a Jenkinsfile
7. ensure Jenkinsfile has at least 'build', 'unit test' and 'integration test' stages
8. push to remote repo
---------------------------
9. on remote repo on SCM like github, create webhook to jenkins server on port 8080 
10. 'http://<my_jenkins_ip>:8080/github-webhook/'
11. keep default config
12. save, check delivery to jenkins server (look for response code 200)
---------------------------
You are now ready to manually trigger your first build
Any changes to your repository on given branch(es) should trigger a build

#######################################################################

create a deploy server using t2.micro

put a private ssh key onto the jenkins server

first, try to ssh onto the deploy server from jenkins with that key (remember chmod 600)

try to ssh onto the machine using the Jenkinsfile/pipeline

install apache but do not customise - enable port 80 and test