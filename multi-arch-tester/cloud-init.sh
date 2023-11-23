#!/bin/bash
# echo "alla" > /tmp/file 
apt-get update
apt-get install docker.io -y


# #cloud-config
# package_update: true
# package_upgrade: true

# apt:
#   sources:
#     docker.list:
#       source: deb [arch=amd64] https://download.docker.com/linux/ubuntu $RELEASE stable
#       keyid: 9DC858229FC7DD38854AE2D88D81803C0EBFCD88

# packages:
#   - docker-ce
#   # - docker-ce-cli
#   - python3-venv
#   - python3-pip

# runcmd:
#   - [ sh, -c, echo "=========git clone jrkessl/exampleMicroservice=========" ]
#   - git -C /home/ubuntu clone https://github.com/jrkessl/exampleMicroservice
#   - chown ubuntu:ubuntu -R /home/ubuntu/exampleMicroservice
#   - chmod 744 -R /home/ubuntu/exampleMicroservice

#   - [ sh, -c, echo "=========nano $HOME/.nanorc=========" ]
#   - echo "set linenumbers" > /home/ubuntu/.nanorc
#   - chown ubuntu:ubuntu /home/ubuntu/.nanorc
#   - chmod 744 /home/ubuntu/.nanorc  

#   - [ sh, -c, echo "=========adicionando ubuntu ao grupo do docker=========" ]
#   - sudo gpasswd -a ubuntu docker 

#   - [ sh, -c, echo "=========instalar aws cli v2=========" ] 
#   - curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"  
#   - sudo apt install unzip
#   - unzip awscliv2.zip
#   - sudo ./aws/install
 
# final_message: "The system is finally up, after $UPTIME seconds"