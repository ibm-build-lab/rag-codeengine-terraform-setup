# Random project suffix
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

locals {
  project_name = "${var.project_name}"
  resource_group = "${var.resource_group}-${random_string.suffix.result}"
  cr_namespace = "${var.cr_namespace}"
  secret = "${var.cr_secret}"
  imagename = "${var.cr_imagename}"
  buildname = "${var.ce_buildname}"
  appname = "${var.ce_appname}"
}

data "ibm_resource_group" "group" {
  name = "${var.resource_group}"
}

resource "ibm_code_engine_project" "code_engine_project_instance" {
  name              = local.project_name
  resource_group_id = data.ibm_resource_group.group.id
}

resource "ibm_cr_namespace" "rg_namespace" {
  name              = local.cr_namespace
  resource_group_id = data.ibm_resource_group.group.id
}

resource "ibm_code_engine_secret" "code_engine_secret_instance" {
  project_id = ibm_code_engine_project.code_engine_project_instance.project_id
  name = local.secret
  format = "registry"
  data = {
      username="iamapikey"
      password="${var.ibmcloud_api_key}"
      server="us.icr.io"
      email=""
    }
}

resource "ibm_code_engine_build" "code_engine_build_instance" {
  project_id    = ibm_code_engine_project.code_engine_project_instance.project_id
  name          = local.buildname
  output_image  = "us.icr.io/${ibm_cr_namespace.rg_namespace.id}/rag-llm"
  output_secret = ibm_code_engine_secret.code_engine_secret_instance.name
  source_url    = "${var.source_url}"
  source_revision = "${var.source_revision}"
  strategy_type = "dockerfile"
}


data "ibm_iam_auth_token" "tokendata" {}

provider "restapi" {
  uri                  = "https://api.${var.region}.codeengine.cloud.ibm.com/"
  debug                = true
  write_returns_object = true
  headers = {
    Authorization = data.ibm_iam_auth_token.tokendata.iam_access_token
  }
}

resource "restapi_object" "buildrun" {
  path     = "/v2/projects/${ibm_code_engine_project.code_engine_project_instance.project_id}/build_runs"
  data = jsonencode(
    {
      name = "rag-llm-build-run"
      output_image  = "${ibm_code_engine_build.code_engine_build_instance.output_image}:latest"
      output_secret = ibm_code_engine_secret.code_engine_secret_instance.name
      source_url    = "${var.source_url}"
      strategy_type = "dockerfile"
      timeout = 3600
    }
  )
  id_attribute = "name"
}

resource "time_sleep" "wait_for_build" {
  create_duration = "10m"

  depends_on = [
    restapi_object.buildrun
  ]
}

resource "ibm_code_engine_app" "code_engine_app_instance" {
  project_id      = ibm_code_engine_project.code_engine_project_instance.project_id
  name            = local.appname
  image_reference = "${ibm_code_engine_build.code_engine_build_instance.output_image}:latest"
  image_secret = local.secret
  image_port = "4050"
  scale_initial_instances = "1"
  scale_max_instances = "1"


  run_env_variables {
    type  = "literal"
    name  = "COS_IBM_CLOUD_API_KEY"
    value = var.cos_ibm_cloud_api_key
  }
  run_env_variables {
    type  = "literal"
    name  = "COS_INSTANCE_ID"
    value = var.cos_instance_id
  }
  run_env_variables {
    type  = "literal"
    name  = "COS_ENDPOINT_URL"
    value = var.cos_endpoint_url
  }
  run_env_variables {
    type  = "literal"
    name  = "RAG_APP_API_KEY"
    value = var.rag_app_api_key
  }
  run_env_variables {
    type  = "literal"
    name  = "IBM_CLOUD_API_KEY"
    value = var.ibmcloud_api_key
  }
  run_env_variables {
    type  = "literal"
    name  = "WX_PROJECT_ID"
    value = var.wx_project_id
  }
  run_env_variables {
    type  = "literal"
    name  = "WX_URL"
    value = var.wx_url
  }
  run_env_variables {
    type  = "literal"
    name  = "WXD_USERNAME"
    value = var.wxd_username
  }
  run_env_variables {
    type  = "literal"
    name  = "WXD_PASSWORD"
    value = var.wxd_password
  }
  run_env_variables {
    type  = "literal"
    name  = "WXD_URL"
    value = var.wxd_url
  }
  run_env_variables {
    type  = "literal"
    name  = "WD_API_KEY"
    value = var.wd_api_key
  }
  run_env_variables {
    type  = "literal"
    name  = "WD_URL"
    value = var.wd_url
  }

}

