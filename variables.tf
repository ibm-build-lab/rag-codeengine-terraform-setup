variable "project_name" {
  type    = string
  default = "watsonxai"
}

variable "resource_group" {
  type    = string
  default = "rag-llm"
}

variable "source_url" {
  type    = string
  default = "https://github.com/ibm-build-lab/RAG-LLM-Service"
}

variable "source_revision" {
  type    = string
  default = "modeldeploy"
}

variable "cr_namespace" {
  type    = string
  default = "rag-images"
}

variable "cr_secret" {
  type        = string
  description = "ce build secret"
  default = "buildsecret"
}

variable "cr_imagename" {
  type        = string
  description = "ce build image"
  default = "gen-llm"
}

variable "ce_buildname" {
  type        = string
  description = "ce build name"
  default = "gen-llm-build"
}

variable "ce_appname" {
  type        = string
  description = "ce application name"
  default = "gen-llm-service"
}

variable "cos_ibm_cloud_api_key" {
  type        = string
  description = "COS API Key"
  default = ""
}

variable "cos_instance_id" {
  type        = string
  description = "COS Instance ID"
  default = ""
}

variable "cos_endpoint_url" {
  type        = string
  description = "COS endpoint"
  default = ""
}

variable "rag_app_api_key" {
  type        = string
  description = "RAG APP User Created Key"
  default = ""
}

variable "wx_project_id" {
  type        = string
  description = "watsonx project id"
  default = ""
}

variable "wx_url" {
  type        = string
  description = "watsonx URL"
  default = ""
}

variable "wxd_username" {
  type        = string
  description = "watsonx discovery user"
  default = ""
}

variable "wxd_password" {
  type        = string
  description = "watsonx discovery password"
  default = ""
}

variable "wxd_url" {
  type        = string
  description = "watsonx discovery URL"
  default = ""
}

variable "wd_api_key" {
  type        = string
  description = "watson discovery apikey"
  default = ""
}

variable "wd_url" {
  type        = string
  description = "watson discovery URL"
  default = ""
}

variable "region" {
  description = "Region"
  type        = string
  default     = "us-south"
}
