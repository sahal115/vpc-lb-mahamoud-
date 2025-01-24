# Security group

resource "aws_security_group" "ws" {
  name = "webser-alb"
  vpc_id = aws_vpc.v1.id 
  description = "80"
  ingress {
     description = "allow 80"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.alb.id]
    #cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

resource "aws_security_group" "alb" {
  name = "alb-code"
  vpc_id = aws_vpc.v1.id
  description = "allow 443, 80"
  ingress {
     description = "allow 80"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
     description = "allow 443"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}


# generate keypair
resource "tls_private_key" "tls" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
resource "aws_key_pair" "key" {
  key_name   = "wpkey"
  public_key = tls_private_key.tls.public_key_openssh
}
resource "local_file" "key1" {
  filename        = "wpkey.pem"
  content         = tls_private_key.tls.private_key_pem
  file_permission = 400
}