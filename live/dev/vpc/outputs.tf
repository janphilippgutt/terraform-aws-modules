# Re-expose module outputs in the wrapper stack so other stacks can consume them

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}