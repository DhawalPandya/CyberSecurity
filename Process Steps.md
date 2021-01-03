######  Azure Resource Group: (Red Team) #######

[RedTeam-Diagram](https://github.com/DhawalPandya/CyberSecurity/blob/main/Screenshot/RedTeam-Diagram.png)

A.	Virtual Network (Red Team Net):

		10.1.0.0/16	Subnet:		10.0.0.0/24

B.	Network Security Group: 

Incoming rule: 

| Type              | Port    | Source IP           | Destination IP    |
|------------------:|:-------:|:-------------------:|:------------------|
|  MY public IP     | 22      | 107.190.0.0/16	    |Virtual Network    |
|  Ssh Jump Box     |  22     |   10.1.0.4	    |Virtual Network    |
|  Http             |  80     | 107.190.0.0/16      |Virtual Network    |

Outbound rule:	 
	          
| Type  		|Private IP   	      | Public IP               |
|----------------------:|:-------------------:|:------------------------|
|Jump Box VM	        | 10.1.0.4            |13.90.94.255             |
| Web -1		| 10.1.0.5	      |137.135.127.119          |
| Web -3  		| 10.1.0.7	      |137.135.127.119          |
               

1.#ssh-keygen (Generate SSH key on Local PC and Copy public key and paste inside the Jump Box ssh password)

2.#ssh AzureUser@13.90.94.255 (Access Jump Box and Log in)

3.azureuser@jump-box: $ sudo apt update

    $ sudo apt install docker.io (Docker install on Jump Box)
    
    $ sudo systemctl status docker (Docker services)
   
    $ sudo systemctl start docker
   
4.$ sudo docker pull cyberxsecurity/ansible (Pull the cyberxsecurity/ansible container inside docker) 
5.$ sudo docker run  -ti cyberxsecurity/ansible:latest bash (Launch the ansible container with docker)
6.$ sudo docker container list -a      or  sudo docker ps

  $ sudo docker start elated_blackwell (Particular container start inside the docker) 
    
 [Docker Container](https://github.com/DhawalPandya/CyberSecurity/blob/main/Screenshot/elated_blackwellContainer.PNG)
 
7.$ sudo docker attach elated_blackwell (Attached container with docker) After Prompt will change 
       
8.Now prompt (root@......) changed and inside the container (Elated_blackwell)
9.$ ssh-keygen (it will generate key inside the: /root/.ssh/id_rsa.pub - - Copy key and paste inside the Web-1/2)
10.$ ssh sysadmin@10.1.0.5 / 7 (Conform connection with Web-1/3)

Web-1
 
 xxxxxx
 
Web -3

 xxxxxx
 
11.Root# sudo nano /etc/ansible/ansible.cfg 	(Change ansible configure file)

   Remote_user = sysadmin

12.Root# sudo nano /etc/ansible/hosts		(Change Hosts file)

	10.1.0.5 ansible_python_interpreter = /usr/bin/python3
	
	10.1.0.7 ansible_python_interpreter= /usr/bin/python3
 
13. root#........: cd /etc/ansible/

14. root#.... /etc/ansible# ansible all -m ping 	(Verify the ansible configuration file)

xxxxxxxxxxx
 
15.root#......:/etc/ansible# nano pentest.yml 		(Run playbook to install docker, python and DVWA on web 1/3)

   xxxxxxxxx
 
16.root#....: /etc/ansible# ansible-playbook pentest.yml
17.root#.... ssh sysadmin@10.1.0.5/7  (connect the web1 and web3 to conform DVWA installation)
18.sysadmin@wen-3: $ curl localhost/setup.php

19.Create Load balancer (On Azure portal)
20.Name: Red-Team-LB

	Add Health probe: RedTeamProbe – TCP – 80,  Interval-5, Unhealthy threshold – 2
    
	Add Backendpool: RedTeamPool – VirtualNetwork (RedTeamNet) – ipv4 – Associate to Virtual machine – 
    
	Virtual Machine (Web-1/ Web -3) and IP address (10.1.0.5 / 10.1.0.7)
	
 I have already made network security rule before, but configuration will be: 

SSH-LBR – Ipv4 – Frontend Address (137.135.127.119) – TCP – 80 – Backend port-80 – backend pool (2 virtual machine) – health 		Probe (TCP-80) – Session Persistence (Client IP and Protocol)

21.Homework would be done, if this DVWA application is working inside any browser: I check it and it is working fine. 

   http://137.135.127.119/setup.php
 
xxxxxxxxxxxxx

Project: 

At last homework, I created 3 Virtual machines (1- Jump box, 2 – web server).

Installed docker and container(elated_blackwell) on jump-box and DVWA on webserver to test vulnerability at web server.

1.For project, I built the one more virtual machine on different region (US West) for ELK

VM Name: 	ELK Server1 – IP: 10.0.0.4 and Public IP: 104.210.51.88 with default subnet under same resource group (Red-Team). Copy public key (jump box, elated_backwell) to new vm computer.

2.Create Virtual network connection between both region (US-East and US-West)

Peering Network Connection: 

(ELK) – End-to-Red	-	 Address space 10.1.0.0/16, 	

(Red team) – Red-to-elk	Address space 10.0.0.0/16,

3.Check the connection from elacted_blackwell container to new ELK server.

 ssh sysadmin@10.0.0.4
   
 xxxxxx
 
4.Edit the hosts file under jumpbox, elated_blackwell container (/etc/ansible/hosts)
    
    [ELKSERVER1}

	10.0.0.4 ansible_python_interpreter=/usr/bin/python3
 
 xxxxxxx
 
5.After configured hosts file, I can run the play book and install packages

  Build the play book to install packages for ELK server.
 	
    xxxxxxxx
    
6.Add ssh access in network security group at ELKServer1NSG
	
    SSH	-	22	-	Any – Any
	
    ELK-Http	5601	-	any-any
    
7.Now check the Kibana is working form browser or not

 Before browser, I can check it in elkserver: 
 
  xxxxxxxx

http://104.210.51.88:5601/app/kibana

 xxxxxxxxx
 
A.After run the kibana, I will install filebeat and metricbeat inside the files folder in ansible.

Fielbeat helps generate and organize log files to send to Logstash and Elasticsearch. It log information about the file system, including which files have changed and when.

xxxxxx
 
B.Run the Filebeat configuration file templete on ansible container.
 
 xxxxxx

C.After install the filebeat configuration file inside the /etc/ansibe/files/filebeat-config.yml
 
 xxxxxxxx
 
D.Edit the filebeat-config.yml  for replace the ip address on elk machine(Ctrl+Shift+ -_ 1106 and 1806)
 
 xxxxx

E.Line 1806 and replace the IP address at ELK Machine
 
 xxxxxx
 
F.Now I create the filebeat installation playbook on /etc/ansible/roles/
 
 xxxxxx
 
G.Create filebeat-playbook (filebeat-playbook.yml)
 
 xxxxx
 
H.After run the playbook and check inside kibana browser, step-5 – Module status – Check data – verify incoming data.
 
  xxxxxxxxx

I.(Filebeat system) syslog dashboard ECS

xxxxxx

J.Now Create Meatricbeat inside the files (/etc/ansible/files/metricbeat)

xxxxxxxx

 
 
 
 


Metricbeat playbook :
 
 xxxxxxxx

After run the metricbeat-playbook, went to bourse:  Kibana-Metrics-Docker metric-DEB-Module Status- Check data
 
 xxxxxxxx
 


 
Thank you for your time,
Dhawal Pandya
