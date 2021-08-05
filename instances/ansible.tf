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

/*Set bastion host dinamically to ansible*/
data "template_file" "ansible_host" {
  template  = templatefile("../templates/hosts.tpl",{dns_name = aws_instance.bastion.public_ip})
}


resource "local_file" "save_host" {
  content = data.template_file.ansible_host.rendered
  filename = "../ansible/hosts/hosts"
}