## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

[Red-Team Network Diagram](https://github.com/DhawalPandya/CyberSecurity/blob/main/Elk-Stack-Diagram/RedTeam-Diagram.JPG)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook (.yml) file may be used to install only certain pieces of it, such as Filebeat.

 [Pentest Playbook](https://github.com/DhawalPandya/CyberSecurity/blob/main/Ansible-Playbook/Pentest.yml) : it run on ansible container to install DVWA on both web server (Web-1 and Web-2) 
  
 [ELK Playbook](https://github.com/DhawalPandya/CyberSecurity/blob/main/Ansible-Playbook/ELK-Playbook.yml) : it run on ansible container to install ELK server
  
 [Metricbeat Playbook](https://github.com/DhawalPandya/CyberSecurity/blob/main/Ansible-Playbook/Filebeat-Playbook.yml) : it install and configure metricbeat on Elk server and Web server
 
 [Filebeat Playbook](https://github.com/DhawalPandya/CyberSecurity/blob/main/Ansible-Playbook/Filebeat-Playbook.yml) :  it install and configure metricbeat on Elk server and Web server 
  
  
This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network. Load balancing help ensure availability through distribution of incoming data to the webservers.
- Advantage: Reduce server workload, increase performance, reduce single point of failure, improve scalability.

Jump box allow for more easy administration of multiple systems and provide an additional security layer between the outside and internal assets. It works as secure admin workstation.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the network and system logs.
- Filebeat monitors the log files or location that you specify, collects log events, and forwards them to either to Elasticsearch or Logstash for Indexing.
- Metricbeat collect metrics and statistics from the operating system and from the services running on the server

The configuration details of each machine may be found below.

| Name     | Function | IP Address | Operating System |Location   |	
|----------|----------|------------|------------------|---------  |
| Jump Box | Gateway  | 10.1.0.4   | Linux VM         |US - East  |
| Web-1    |Webserver | 10.1.0.5   | Linux VM         |US- East   |
| Web-3    |Webserver | 10.1.0.7   | Linux VM         |US -East   |
| ELK      |Webserver | 10.0.0.4   | Linux VM         |US - West  |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the JumpBox machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- Personal IP addresses (107.190.0.0/16)

Machines within the network can only be accessed by JumpBox.
- Only ELK VM machine has access from the personal ip with 5601 port. [http://104.210.51.88:5601/app/kibana](https://github.com/DhawalPandya/CyberSecurity/blob/main/Screenshot/KibanaWebpage.PNG)

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses 	     |
|----------|---------------------|-------------------------------|
| Jump Box | No(ssh public key)  | 10.1.0.4 / 13.90.94.255	     |
| Web-1    | Yes, through LB     | 10.1.0.4 / 137.135.127.119    |                     	
| Web-3    | Yes, through LB     | 10.1.0.4 / 137.135.127.119    |
| ELK      |  Yes                | 10.1.0.4 / 104.210.51.88:5601 |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because services running can be limited, system installation and update can be streamlined, and process become more replicable.
- What is the main advantage of automating configuration with Ansible?

One of the main advantages of .YML playbook, it is the best alternative for configuration management/automation.
It is also able to automate complex multi-tier IT application environment
It can deploy multiple servers easily and quickly without having to physically touch each server.


The playbook implements the following tasks:
- In 3-5 bullets, explain the steps of the ELK installation play. E.g., install Docker; download image; etc._
- 1.	Connect to jump box form local pc. (# ssh azureuser@13.90.94.255) 
- 2.	Install the docker on jump box. (# sudo apt install docker.io) 
- 3.	Pull the cyberxsecurity/ansible container inside docker. (# sudo docker pull cyberxsecurity/ansible)
- 4.	Find out the Container list on docker (# sudo docker container list -a / ps)
- 5.	Start / attach the ansible container. (# sudo docker start/attach container elated_blackwell)
- 6.	Went to /etc/ansible/roles directory and created the ELK playbook (Elk_Playbook.yml)
- 7.	Ran the Elk_Playbook.yml in that same directory (ansible-playbook Elk_Playbook.yml)
- 8.	Lastly, I SSH into the ELK-VM to verify the server is up and running

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

[Screenshot of docker ps](https://github.com/DhawalPandya/CyberSecurity/blob/main/Screenshot/Docker-ps.PNG)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web Server – 1		10.1.0.5
- Web Server – 3		10.1.0.7

We have installed the following Beats on these machines:
- Filebeat configuration and playbook
- Metricbeat configuration and playbook


These Beats allow us to collect the following information from each machine:
- In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc.

- Filebeat is a log data shipper for local files. Installed as an agent on your servers, Filebeat monitors the log directories or specific log files, tails the files, and forwards them either to Elasticsearch or Logstash for indexing. An example of such are the logs produced from the MySQL database supporting our application

- Metricbeat collects metrics and statistics on the system. An example of such is CPU usage, which can be used to monitor the system health. Metricbeat records metrics and statistical data from the operating system and from services running on the server (Metricbeat: Lightweight Shipper for Metrics)


### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the configuration file from ansible container to web server.
- Update the /etc/ansible/hosts file to include IP address of ELK server and Web servers.
- Run the playbook, and navigate to http://[your.ELK-VM.External.IP]:5601/app/kibana to check that the installation worked as expected.

Answer the following questions to fill in the blanks:_ Where do you copy it?
- Which file is the playbook?
  Pretest.yml (/etc/ansible/)
  ElkServer.playbook.yml (/etc/ansible/)
  filebeat.playbook.yml (/etc/ansible/roles)
  metricbeat.playbook.yml (/etc/ansible/roles)
  
   
- Which file do you update to make Ansible run the playbook on a specific machine? 
  Hosts file (Location: /etc/ansible/hosts)
	
	         [webserver]
	
	10.1.0.5 ansible_python_interpreter=/usr/bin/python3 (IP address of VM web)
	
	10.1.0.7 ansible_python_interpreter=/usr/bin/python3
	
		 [Elk server]
			
	10.0.0.4 ansible_python_interpreter=/usr/bin/python3  

- How do I specify which machine to install the ELK server on versus which to install Filebeat on?_

  There is two separate groups in side the Hosts file(/etc/ansible/hosts).one group for the WEBServer and has IP address of web machine, where I will install filebeat and metricbeat too Another group for ELK server and it has own separate ip addtes, Where I can install ELK. 

- Which URL do you navigate to in order to check that the ELK server is running?

 http://[your.ELK-VM.External.IP]:5601/app/kibana.
 
 [http://104.210.51.88:5601/app/kibana](https://github.com/DhawalPandya/CyberSecurity/blob/main/Screenshot/KibanaWebpage.PNG)

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
