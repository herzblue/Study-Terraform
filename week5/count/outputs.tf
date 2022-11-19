output "first_arn" {
  value       = aws_iam_user.myiam[0].arn#0번째 배열 이름을 값으로 받는다.
  description = "The ARN for the first user"
}

output "all_arns" {
  value       = aws_iam_user.myiam[*].arn#전부 다
  description = "The ARNs for all users"
}
