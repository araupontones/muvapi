#Exercise to GET data from one record
library(jsonlite)
#load secrets and server info
gmdacr::load_functions('vault/')


#1. Define report parameters ===================================================


account_owner_name <- 'araupontones'
app_link_name <- 'realiza'
report_link_name <- 'Presencas_IND_SGR_report'



#refresh access token ===========================================================
access_token <- create_access_token()

# 3. GET RECORDS FROM REPORT ===================================================



request_url_get <- glue('https://{base_url}/creator/v2.1/data/{account_owner_name}/{app_link_name}/report/{report_link_name}')

request_get <- request(request_url_get) |>
  req_headers(
    Authorization = paste('Zoho-oauthtoken', access_token),
    accept = 'application/json'
  )



#Check the request
req_dry_run(request_get)

resp_get <- request_get |> req_perform()

status <- resp_status(resp_get)

#if token expiro, create a new 
if(status != 200){
  
  req <- request(request_url_refresh) |>
    req_method('POST')
  
  #Check the request
  req_dry_run(req)
  
  # get access token : remember that expires every 3,600 segundos
  
  resp <- req |> req_perform()
  
  resp_json <- resp_body_json(resp)
  access_token <- resp_json$access_token
  
  #Perform the request again
  resp_get <- request_get |> req_perform()
  resp_json_reporte <- resp_get |> resp_body_json()
  
  
  
}

if(status == 200){
  
  resp_json_reporte <- resp_get |> resp_body_json()
  
  
}




