---
- name: Install docker in master
  include: docker.yml

- name: Ansible Front Playbook
  gather_facts: false
  hosts: tag_aws_autoscaling_groupName_Production_Backend_AutoScalingGroup
  tasks:
    - name: Stop Current Container
      docker_container:
        name: backend
        state: stopped

    - name: Remove image
      docker_image:
        state: absent
        name: juan2203/movie-api
        tag: latest
        force: yes

    - name: Pull Last Docker image
      docker_image:
        name: "juan2203/movie-api:latest"
        source: pull

    - name: Run Containers
      docker_container:
        name: "backend"
        image: "juan2203/movie-api:latest"
        command: npm start
        state: started
        published_ports:
            -   "3000:3000"
        env:
            MYSQL_HOST: ${database_host}
            MYSQL_USER: ${database_username}
            MYSQL_PASS: ${database_password}