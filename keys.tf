resource "aws_key_pair" "mykeypair" {
  key_name   = "mykeypair_jkslave"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}