ibmcloud_api_key = ""
region = "us-south"
cos_ibm_cloud_api_key = ""
cos_endpoint_url = "https://s3.us-south.cloud-object-storage.appdomain.cloud"
cos_instance_id = ""
bucket_name = ""
wx_project_id = ""
wxd_username = ""
wxd_password = ""
wxd_url = "https://<host>:<port>"
wx_url = "https://us-south.ml.cloud.ibm.com"
index_name = "rag-llm-index"
pipeline_name = "rag-llm-pipeline"
llm_instructions="[INST]<<SYS>>You are a helpful, respectful, and honest assistant. Always answer as helpfully as possible, while being safe. Be brief in your answers. Your answers should not include any harmful, unethical, racist, sexist, toxic, dangerous, or illegal content. Please ensure that your responses are socially unbiased and positive in nature.\nIf a question does not make any sense, or is not factually coherent, explain why instead of answering something not correct. If you do not know the answer to a question, please do not share false information. <</SYS>>\nGenerate the next agent response by answering the question. You are provided several documents with titles. If the answer comes from different documents please mention all possibilities and use the tiles of documents to separate between topics or domains. Answer with no more than 150 words. If you cannot base your answer on the given document, please state that you do not have an answer.\n{context_str}<</SYS>>\n\n{query_str} Answer with no more than 150 words. If you cannot base your answer on the given document, please state that you do not have an answer. [/INST]"
