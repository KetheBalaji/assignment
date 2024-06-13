output "instance_public_ip" {
 value = aws_instance.microservice.public_ip
}
output "load_balancer_dns" {
 value = aws_lb.alb.dns_name
}
