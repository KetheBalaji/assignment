resource "aws_lb" "alb" {
 name               = "microservice-alb"
 internal           = false
 load_balancer_type = "application"
 security_groups = [aws_security_group.sg.id]
 subnets = [aws_subnet.subnet1.id,aws_subnet.subnet2.id]
}
resource "aws_lb_target_group" "tg" {
 name     = "microservice-tg"
 vpc_id = aws_vpc.vpc.id
 port     = 80
 protocol = "HTTP"
}
resource "aws_lb_listener" "lb_listener" {
 load_balancer_arn = aws_lb.alb.arn
 port              = "80"
 protocol          = "HTTP"
 default_action {
   type             = "forward"
   target_group_arn = aws_lb_target_group.tg.arn
 }
}
resource "aws_lb_target_group_attachment" "lb_target_group" {
 target_group_arn = aws_lb_target_group.tg.arn
 target_id        = aws_instance.microservice.id
 port             = 80
}