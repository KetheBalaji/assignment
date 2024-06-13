resource "aws_instance" "microservice" {
 ami           = "ami-00beae93a2d981137"
 instance_type = var.instance_type
 key_name      = var.sshkey_name
 subnet_id = aws_subnet.subnet1.id
 security_groups = [aws_security_group.sg.id]
user_data = <<-EOF
             #!/bin/bash
             sudo cd /home/ec2-user
             sudo yum update -y
             sudo yum install docker -y
             sudo usermod -a -G docker ec2-user
             sudo chkconfig docker on
             sudo chmod 666 /var/run/docker.sock
             sudo yum install -y aws-cli
             sudo mkdir /home/ec2-user/microservice
             sudo echo "Welcome to Microservice" > /home/ec2-user/microservice/index.html
             sudo chmod +x /home/ec2-user/microservice/index.html
             sudo touch /home/ec2-user/microservice/Dockerfile
             sudo echo -e "FROM nginx:alpine\nCOPY index.html /usr/share/nginx/html/index.html\nEXPOSE 80" >> /home/ec2-user/microservice/Dockerfile
             sudo chmod +x /home/ec2-user/microservice/Dockerfile
             sudo service docker start
             cd /home/ec2-user/microservice
             sudo docker build -t microservice .
             sudo docker run -d -p 80:80 microservice
             aws configure set aws_access_key_id AKIAZI2LIQHI7AB6RLM7
             aws configure set aws_secret_access_key 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
             aws configure set region us-east-1
             aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 637423616465.dkr.ecr.us-east-1.amazonaws.com
             docker tag microservice:latest 637423616465.dkr.ecr.us-east-1.amazonaws.com/my-microservice:latest
             docker push 637423616465.dkr.ecr.us-east-1.amazonaws.com/my-microservice:latest
            EOF
 tags = {
   Name = "microservice"
 }
}