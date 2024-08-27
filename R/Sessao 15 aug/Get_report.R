#Exercise to GET data from one record
library(jsonlite)
# Define Parameters =============================================================
#refresh access token
base_accounts_url <- 'https://accounts.zoho.com'


request_url_refresh  <- glue('{base_accounts_url}/oauth/v2/token?refresh_token={refresh_token}&client_id={client_id}&client_secret={client_secret}&grant_type=refresh_token')


# 2. Create access token  ============================================================


req <- request(request_url_refresh) |>
  req_method('POST')

#Check the request
req_dry_run(req)

# get access token : remember that expires every 3,600 segundos

resp <- req |> req_perform()

resp_json <- resp_body_json(resp)
access_token <- resp_json$access_token


# 3. GET RECORDS FROM REPORT ===================================================
#To know which is my base_url
#https://help.zoho.com/portal/en/kb/creator/developer-guide/others/url-patterns/articles/know-your-creator-account-s-base-url

base_url <- 'www.zohoapis.com'
account_owner_name <- 'araupontones'
app_link_name <- 'realiza'
report_link_name <- 'Presencas_IND_SGR_report'


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





