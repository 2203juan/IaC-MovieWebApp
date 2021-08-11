/*Fit mysql playbook with login info*/
data "template_file" "mysql_playbook" {
    template = templatefile("../templates/database_config.tpl",
    {
        database_username = var.db_user_name,
        database_password = var.db_password,
        database_host = aws_db_instance.dbmovie.address
    })
}

resource "local_file" "save_mysql_host_config" {
  content = data.template_file.mysql_playbook.rendered
  filename = "../ansible/roles/mysql/vars/main.yml"
}

/*Set bastion host dinamically to ansible (mysql-init-playbook)*/
data "template_file" "ansible_host" {
  template  = templatefile("../templates/hosts.tpl",{dns_name = aws_instance.bastion.public_ip})
}


resource "local_file" "save_host" {
  content = data.template_file.ansible_host.rendered
  filename = "../ansible/hosts/hosts"
}

/*Frontend playbook -> set dinamically backend loadbalancer endpoint*/
data "template_file" "ansible_front" {
  template  = templatefile("../scripts/front_playbook.tpl",{back_lb_endpoint = aws_elb.backend_load_balancer.id})
}

resource "local_file" "save_front_playbook" {
  content = data.template_file.ansible_front.rendered
  filename = "/home/juanhoyosu/Documents/RampUp/ansible_deploy_front/ansible/front_playbook.yml"
}

/*Backend playbook -> set dinamically mysql endpoint and credentials*/
data "template_file" "ansible_back" {
  template  = templatefile("../scripts/back_playbook.tpl",
  {
        database_username = var.db_user_name,
        database_password = var.db_password,
        database_host = aws_db_instance.dbmovie.address
  
  })
}

resource "local_file" "save_back_playbook" {
  content = data.template_file.ansible_back.rendered
  filename = "/home/juanhoyosu/Documents/RampUp/ansible_deploy_back/ansible/back_playbook.yml"
}