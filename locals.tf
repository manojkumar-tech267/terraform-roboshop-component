locals {
    sg_id = ""
     common_tags = {
        Project = var.project
        Environment = var.environment
        Terraform = "true"
    }
    component_final_tags = merge(
        {
            Name = "${var.project}-${var.environment}-${var.component}"
        },
        local.common_tags
    )
    aws_ami_final_tags = merge(
        {
            Name = "${var.project}-${var.environment}-${var.component}"
        },
        local.common_tags
    )
    launch_template_final_tags = merge(
        {
            Name = "${var.project}-${var.environment}-${var.component}"
        },
        local.common_tags
    )
    autoscaling_tags = merge(
        {
            Name = "${var.project}-${var.environment}-${var.component}"
        },
        local.common_tags
    )
    ami_id = data.aws_ami.roboshop.id
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    private_subnet_id = split(",", data.aws_ssm_parameter.private_subnet_ids.value)[0]
    sg_id = data.aws_ssm_parameter.sg_id.value
    health_check_path = var.component == "frontend" ? "/" : "/health"
    port_number = var.component == "frontend" ? 80 : 8080
    backend_alb_listener_arn = data.aws_ssm_parameter.backend_alb_listener_arn.value
    frontend_alb_listener_arn = data.aws_ssm_parameter.frontend_alb_listener_arn.value
    alb_listener_arn = var.component == "frontend" ? local.frontend_alb_listener_arn : local.backend_alb_listener_arn
    host_header = var.component == "frontend" ? "${var.component}-${var.environment}.${var.domain_name}" : "${var.component}.backend-alb-${var.environment}.${var.domain_name}"
}