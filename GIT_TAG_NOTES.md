#  NOTES — Using Git Tags in This Project

##  What Is a Git Tag?

A Git tag is like a bookmark in your project’s history. It marks a specific version of your code that is important or ready for others to use.

For example, `v1.0.0` might mean:
> “The first complete version of the VPC and EC2 modules.”

##  Why Use Tags?

- So others can safely use a specific version of your modules.
- To avoid accidentally breaking someone’s code when you make changes.
- To roll back to a stable version if something breaks.

##  How to Create a Tag

1. Make sure your code is committed:
   ```bash
   git commit -m "Prepare first stable release" 
   ```
2. Create the tag:
```
git tag -a v1.0.0 -m "First stable version of VPC and EC2 modules"
```
3. Push the tag to GitHub:
```
git push origin v1.0.0
```
## How to Use a Tagged Version in Terraform

When using this module from GitHub, refer to the tag like this:
```module "vpc" {
  source = "git::https://github.com/YOUR_USERNAME/terraform-aws-modules.git//modules/vpc?ref=v1.0.0"
  ...
}
```
This ensures you are using a specific, stable version of the code.

## Tag Naming Convention in this repo

    v1.0.0 — First full version

    v1.1.0 — New feature added

    v2.0.0 — Breaking changes or big updates