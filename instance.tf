resource "aws_instance" "jenkins-slave" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = var.AWS_INSTANCE_FLAVOR
  key_name      = aws_key_pair.mykeypair.key_name
  provisioner "local-exec" {
    #Add host to ./ssh/config
    command = "sh ./scripts/add-host.sh jenkins-slave ${self.public_ip} ubuntu ~/aws-jenkins-slave/ssh_keys/mykey >> ~/.ssh/config"
  }
  provisioner "local-exec" {
      # remove host from ./ssh/config
      when    = destroy
      command = "sh ./scripts/remove-host.sh jenkins-slave ~/.ssh/config"
  }
}