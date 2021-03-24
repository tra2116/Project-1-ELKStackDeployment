## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Screen Shot 2021-03-23 at 4 19 10 PM](https://user-images.githubusercontent.com/65363042/112223470-5e9a6f00-8c00-11eb-872f-b76b61bc9112.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the uploaded Azure infrastructure files may be used to install only certain pieces of it, such as Filebeat, or Metricbeat.

[FileBeat Playbook](https://github.com/tra2116/Project-1-ELKStackDeployment/blob/main/Ansible%20Scripts/Install-Filebeat/filebeat-playbook.yml)
[Metricbeat Playbook](https://github.com/tra2116/Project-1-ELKStackDeployment/blob/main/Ansible%20Scripts/Install-Metricbeat/metricbeat-playbook.yml)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build

### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting inbound access to the network. The off-loading function of a load balancer defends an organization against distributed denial-of-service DDoS attacks attacks. This is ensured through distribution of incoming traffic among multiple web servers. Access control through jump box ensures that only authorized users are able to connect to the internal network. A jump box, or a jump server is a machine on a network used to manage access to devices.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the file systems on the network and system log and metric files, such as application logs, service logs, event logs, authentication logs, attempted SSH logins, and escalation failures, etc.

The three web servers, Web-1, Web-2, and Web-3, have Filebeat and Metricbeat installed on them. Filebeat is a lightweight shipper for forwarding and centralizing log data. It monitors the log files, collects log events, and forwards them to the Elasticsearch/Logstash for indexing. Whereas, Metricbeat periodically collects metrics from the operating system and from services running on the server. It takes those metrics and statistics and ships them to the Elasticsearch/Logstash.

The configuration details of each machine may be found below.

| Name     | Function   | Public IP Address | Private IP Address | Operating System |
|----------|------------|-------------------|--------------------|------------------|
| Jump Box | Gateway    | 52.151.56.202     | 10.0.0.4           | Linux            |
| Web-1    | Web Server | N/A               | 10.0.0.5           | Linux            |
| Web-2    | Web Server | N/A               | 10.0.0.6           | Linux            |
| Web-3    | Web Server | N/A               | 10.0.0.7           | Linux            |
| ELK      | Monitoring | 40.123.36.51      | 10.1.0.4           | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the jump box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP address:
185.240.244.164.

Machines within the network can only be accessed by accessing the ansible container in the jump box VM. The Web-1, Web-2, and Web-3 VMs can send traffic to the ELK server. Access to ELK server is only allowed from IP address 185.240.244.164, my personal machine, and the jump box VM at IP 10.1.0.4. 

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Address         |
|----------|---------------------|----------------------------|
| Jump Box | Yes                 | 185.240.244.164            |
| Web-1    | No                  | 10.0.0.4                   |
| Web-2    | No                  | 10.0.0.4                   |
| Web-3    | No                  | 10.0.0.4                   |
| ELK      | No                  | 10.0.0.4, 185.240.244.164  |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because there is no need to install any other software on the systems you want to automate. Neither is there any need to set up a separate management structure.

The [install-elk-server.yml](https://github.com/tra2116/Project-1-ELKStackDeployment/blob/main/Ansible%20Scripts/Configure-ELK-Stack/install-elk-server.yml) playbook implements the following tasks:
- Install Docker
- Install Docker Python Module
- Increase virtual memory
- Download Docker ELK container
- Launch ELK container

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.
![Screen Shot 2021-03-23 at 4 19 10 PM](https://user-images.githubusercontent.com/65363042/112235440-07eb6000-8c15-11eb-8dec-eff509861168.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1 at 10.0.0.5
- Web-2 at 10.0.0.6
- Web-3 at 10.0.0.7

We have installed the following Beats on these machines: - Filebeat - Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat: Detects changes to the filesystem.
- Metricbeat: Detects changes to the system metrics.

<img width="1342" alt="  d " src="https://user-images.githubusercontent.com/65363042/112236137-3c135080-8c16-11eb-96ce-d9c7f44938ad.png">

<img width="1360" alt="Screen Shot 2021-03-20 at 6 33 21 PM" src="https://user-images.githubusercontent.com/65363042/112236148-3f0e4100-8c16-11eb-8e27-f8e0de63f539.png">

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the _____ file to _____.
- Update the _____ file to include...
- Run the playbook, and navigate to ____ to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it?_
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
- _Which URL do you navigate to in order to check that the ELK server is running?

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
