# mosip-security
This is sceurity framework for mosip e2e security

#Steps:
1. Create a sudo less user on machine
2. install git on the machine
3. install ansible on the machine
4. Clone the repo.
5. rename the file group_vars/all.yml to <yourhostname>.yml
6. run playbook using ansible-playbook -i hosts.ini start.yml