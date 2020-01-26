data "template_file" "jenkins-slave-init" {
  template = file("scripts/jenkins-slave-init.sh")
}

data "template_cloudinit_config" "cloudinit-jenkins" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.jenkins-slave-init.rendered
  }
}