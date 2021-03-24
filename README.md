## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Screen Shot 2021-03-23 at 4 19 10 PM](https://user-images.githubusercontent.com/65363042/112223470-5e9a6f00-8c00-11eb-872f-b76b61bc9112.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the uploaded Azure infrastructure files may be used to install only certain pieces of it, such as Filebeat, or Metricbeat.

- [FileBeat Playbook](https://github.com/tra2116/Project-1-ELKStackDeployment/blob/main/Ansible%20Scripts/Install-Filebeat/filebeat-playbook.yml)

- [Metricbeat Playbook](https://github.com/tra2116/Project-1-ELKStackDeployment/blob/main/Ansible%20Scripts/Install-Metricbeat/metricbeat-playbook.yml)

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

<img width="1357" alt="Screen Shot 2021-03-20 at 4 29 28 PM" src="https://user-images.githubusercontent.com/65363042/112236412-c491f100-8c16-11eb-828b-2cf30adaac36.png">

The ELK playbook is duplicated below:

```
---
- name: Configure Elk VM with Docker
  hosts: elk
  remote_user: azadmin
  become: true
  tasks:

    # Use apt module
    - name: Install docker.io
      apt:
        update_cache: yes
        name: docker.io
        state: present

      # Use apt module
    - name: Install pip3
      apt:
        force_apt_get: yes
        name: python3-pip
        state: present

      # Use pip module
    - name: Install Docker python module
      pip:
        name: docker
        state: present

      # Use sysctl module
    - name: Use more memory
      sysctl:
        name: vm.max_map_count
        value: "262144"
        state: present
        reload: yes

      # Use docker_container module
    - name: download and launch a docker elk container
      docker_container:
        name: elk
        image: sebp/elk:761
        state: started
        restart_policy: always
        published_ports:
          - 5601:5601
          - 9200:9200
          - 5044:5044

      # Use systemd module
    - name: Enable Docker on Boot
      systemd:
        name: docker
        enabled: yes
```

### Target Machines & Beats

This ELK server is configured to monitor the following machines:
- Web-1 at 10.0.0.5
- Web-2 at 10.0.0.6
- Web-3 at 10.0.0.7

We have installed the following Beats on these machines: - Filebeat - Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat: Detects changes to the filesystem.

<img width="1342" alt="  d " src="https://user-images.githubusercontent.com/65363042/112236137-3c135080-8c16-11eb-96ce-d9c7f44938ad.png">

- Metricbeat: Detects changes to the system metrics.

<img width="1360" alt="Screen Shot 2021-03-20 at 6 33 21 PM" src="https://user-images.githubusercontent.com/65363042/112236148-3f0e4100-8c16-11eb-8e27-f8e0de63f539.png">

The Filebeat playbook is duplicated below:

```
---
- name: installing and launching filebeat
  hosts: webservers
  become: yes
  tasks:

    # Use command module
  - name: download filebeat deb
    command: curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.4.0-amd64.deb
 
    # Use command module
  - name: install filebeat deb
    command: dpkg -i filebeat-7.4.0-amd64.deb

    # Use copy module 
  - name: drop in filebeat.yml 
    copy:
      src: /etc/ansible/files/filebeat-config.yml
      dest: /etc/filebeat/filebeat.yml

    # Use command module
  - name: Enable and Configure System Module
    command: filebeat modules enable system

    # Use command module
  - name: setup filebeat
    command: filebeat setup

    # Use command module
  - name: start filebeat service
    command: service filebeat start

    # Use systemd module
  - name: enable service filebeat on boot
    systemd:
      name: filebeat
      enabled: yes
```

The Metricbeat playbook is duplicated below:

```
---
- name: Install metric beat
  hosts: webservers
  become: true
  tasks:
  
    # Use command module
  - name: Download metricbeat
    command: curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.4.0-amd64.deb

    # Use command module
  - name: install metricbeat
    command: dpkg -i metricbeat-7.4.0-amd64.deb

    # Use copy module
  - name: drop in metricbeat config
    copy:
      src: /etc/ansible/files/metricbeat-config.yml
      dest: /etc/metricbeat/metricbeat.yml

    # Use command module
  - name: enable and configure docker module for metric beat
    command: metricbeat modules enable docker

    # Use command module
  - name: setup metric beat
    command: metricbeat setup

    # Use command module
  - name: start metric beat
    command: service metricbeat start

    # Use systemd module
  - name: enable service metricbeat on boot
    systemd:
      name: metricbeat
      enabled: yes
```

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. I had jump box provisioned for this purpose.  

To use the playbooks, SSH into the control node and follow the steps: 
- Copy the playbooks to the Ansible control node.
- Run each playbook on the appropriate targets.

The easiest way to copy the playbooks from this repository would be to clone them and copy the configuration file from your ansible container to your Web VMs.

```
$ cd /etc/ansible
$ mkdir files
$ git clone https://github.com/tra2116/project-1-elkstackdeployment.git
# Move Playbooks and hosts file into `/etc/ansible`
$ cp project-1-elkstackdeployment/playbooks/* .
$ cp project-1-elkstackdeployment/files/* ./files
```

This will copy the playbook files to the correct directory. 

Next, you must update the `/etc/ansible/hosts` file to include the IP address of the Elk Server VM and webservers. Run the commands below:

```
$ cd /etc/ansible
$ nano hosts
# Modify the hosts file
```

Eventually, hosts file will look like this. Note:_Your IPs might be different._

<img width="1440" alt="Screen Shot 2021-03-20 at 3 36 49 PM" src="https://user-images.githubusercontent.com/65363042/112308171-39494780-8c78-11eb-8208-ca59eb892cb4.png">

After this, run the playbook. Commands below run the playbook:

```
$ cd /etc/ansible
$ ansible-playbook dvwa-playbook.yml
$ ansible-playbook install-elk-server.yml
$ ansible-playbook filebeat-playbook.yml
$ ansible-playbook metricbeat-playbook.yml
```

To verify success, navigate to http://[40.123.36.51]:5601/app/kibana to check that the installation worked as expected. 

- Which file is the playbook? 
- Where do you copy it?_
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
- _Which URL do you navigate to in order to check that the ELK server is running? http://[your.ELK-VM.External.IP]:5601/app/kibana.

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
