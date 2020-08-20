# mosip-security
This is sceurity framework for mosip e2e security

#Steps:
1. Create a sudo less user on machine.
2. install git on the machine
3. install ansible on the machine
4. Setup oracle java on Machine
5. Set JAVA_HOME in path
4. Clone the repo.
5. Run playbook using ansible-playbook -i hosts.ini run.yml

Note: Set ansible to run for localhost as well. If you want to run the test from putty or remote location. Please enable "X11Forward true" for server and for putty or any console.