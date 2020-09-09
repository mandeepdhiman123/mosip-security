# mosip-security
This framework is designed for mosip e2e security. this framework will cover below security testings:

1. Basic setup of all the required tools, packages for the framework
2. Build latest functional test rig for Mosip.
3. OS hardening of your complete cluster
4. Aggressive port scanning of complete cluster
5. Port scanning of domain
6. Network Scanning of complete cluster
7. Docker scanning of complete cluster
8. e2e API scanning for vulnerabilities 
9. Setup scheduled cron jobs for daily functional stability run.
10. Git workflow to scan all your repositories for secrets.

#Requirements:
1. Ubuntu 18.04 or above, 16 GB RAM, 2 Cores, 120 GB hard-drive.
2. Install git to clone the repo. 
3. Install ansible for running the script.
4. Create a sudo less user on machine.
5. Setup java on machine.

#Prerequisite:
1. Clone the repo.
2. Edit variables file under group_vars/all.yml
3. Change below parameters according to requirements: <br/>

<b>For API security testing</b><br/>
play_dir <br/>
target_name: 'Mosip' <br/>
target_uri: 'https://qa.mosip.net/' <br/>
context: 'qa.mosip.net' <br/>
author: 'Mandeep Dhiman' <br/>
scan_policy: 'Default Policy' <br/>
module: 'prereg' *****for module wise run <br/>
module: 'all'   *****for complete e2e run <br/>
envuser: 'qa' <br/>
testlevel: 'smoke' <br/>
host: '127.0.0.1' <br/>
port: '8090' <br/>

<b>For running/scheduling only functional test rig</b> <br/>
schedule_time: '1' <br/>
modules: '[ "prereg", "kernel", "admin", "regproc", "idrepository", "resident", "partner" ]'  for parallel processing <br/>
modules: '["all"]' for sequencial processing  <br/>

<b>For OS hardening</b> <br/>
oscap_profile: 'xccdf_org.ssgproject.content_profile_pci-dss'  <br/>
oscap_policy: 'ssg-centos7-ds' <br/>


<b>For nmap</b> <br/>
scan_type: '-p- -Pn -sS -A --script banner' <br/>

<b>For Git Hub Repo</b><br/>
1. You need to add your github repository URL in batch.txt file.
2. Reschedule your workflow by changing time in repo-scanner.yml file.

#Run
1. Run playbook using ansible-playbook -i hosts.ini run.yml
2. Network scanning is available through OpenVAS. You can access the url @ https://<Your IP>:4000/.
3. Command line scripts for cluster scanning is in progress. Available with version 2.0.


#WorkFlow:

![title](./mosip-security-playbook/utils/Playbook-Flow.png)&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;

<br/>
<br/>
<br/>

<b>Note:</b> Set ansible to run for localhost as well. If you want to run the test from putty or remote location. Please enable "X11Forward true" for server and for putty or any console.
<br/>

Thanks for RoboZap python library