cd infrastructure/
terraform apply -var-file="production.tfvars"

cd ../instances/
terraform apply -var-file="production.tfvars"

cd ../ansible/playbooks/
ansible-playbook init_database.yml

cd ../../../../ansible_deploy_back/ansible/
git add .
git commit -m "updated endpoints"
git push origin main

cd ../../ansible_deploy_front/ansible/
git add .
git commit -m "updated endpoints"
git push origin main