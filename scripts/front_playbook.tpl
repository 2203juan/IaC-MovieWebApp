---
- name: Install docker in master
  include: docker.yml

- name: Ansible Front Playbook
  gather_facts: false
  hosts: tag_aws_autoscaling_groupName_Production_WebApp_AutoScalingGroup
  tasks:
    - name: Stop Current Container
      docker_container:
        name: front
        state: stopped

    - name: Remove image
      docker_image:
        state: absent
        name: juan2203/movie-ui
        tag: latest
        force: yes

    - name: Pull Last Docker image
      docker_image:
        name: "juan2203/movie-ui:latest"
        source: pull

    - name: Run Containers
      docker_container:
        name: "front"
        image: "juan2203/movie-ui:latest"
        command: npm start
        state: started
        published_ports:
            -   "3030:3030"
        env:
            BACK_HOST: ${back_lb_endpoint}