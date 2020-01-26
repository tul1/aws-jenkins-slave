output "jenkins-slave-ip" {
  value = aws_instance.jenkins-slave.public_ip
}
