# ECR Module

This module creates an **Amazon Elastic Container Registry (ECR)** repository with optional image scanning and a lifecycle policy to automatically expire older images.

## Inputs

| Name              | Type   | Default | Description                                                                 |
| ----------------- | ------ | ------- | --------------------------------------------------------------------------- |
| `name`            | string | n/a     | **(Required)** Name of the ECR repository                                   |
| `scan_on_push`    | bool   | `true`  | Whether to scan images for vulnerabilities on push                          |
| `max_image_count` | number | `10`    | How many images to keep. Older images will be deleted by the lifecycle rule |

## Outputs

| Name              | Description                            |
| ----------------- | -------------------------------------- |
| `repository_url`  | Full URL of the created ECR repository |
| `repository_name` | Name of the created ECR repository     |


## Usage

```hcl
module "frontend_ecr" {
  source          = "./modules/ecr"
  name            = "frontend"
  scan_on_push    = true
  max_image_count = 10
}

module "api_ecr" {
  source          = "./modules/ecr"
  name            = "api"
  scan_on_push    = true
  max_image_count = 10
}
```

## Notes and Learnings

- **Image tag mutability:**
    By default, this module sets image_tag_mutability = "MUTABLE".
    - MUTABLE: A tag like :latest can be overwritten.

    - IMMUTABLE: Once pushed, a tag cannot be reused. 
    Many production teams prefer IMMUTABLE to ensure traceability, but MUTABLE is simpler for early pipelines.
      

- **Lifecycle policy:**

    - This module configures a rule to keep only the last max_image_count images.

    - Example: If max_image_count = 5 and you push a 6th image, the oldest image will be expired automatically.

    - This keeps the registry clean and avoids unnecessary storage costs.
  

- **DSGVO (GDPR) note:**
ECR stores data regionally. To remain compliant, ensure your repositories are created in an EU region (e.g., eu-central-1).
