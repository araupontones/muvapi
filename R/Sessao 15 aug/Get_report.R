#Exercise to GET data from one record

#load secrets and server info
gmdacr::load_functions('vault/')
gmdacr::load_functions('utils/')


#1. Define report parameters ===================================================


account_owner_name <- 'araupontones'
app_link_name <- 'uk-pact'
report_link_name <- 'Download_outputs'



#refresh access token ===========================================================
access_token <- create_access_token()

# 3. GET RECORDS FROM REPORT ===================================================



request_url_get <- glue('https://{server_info()$base_url}/creator/v2.1/data/{account_owner_name}/{app_link_name}/report/{report_link_name}')

#first request =================================================
request_get <- request(request_url_get) |>
  req_headers(
    Authorization = paste('Zoho-oauthtoken', access_token),
    accept = 'application/json'
  ) |>
  req_url_query(max_records = 1000)



#Check the request
req_dry_run(request_get)

resp_get <- request_get |> req_perform()

status <- resp_status(resp_get)
status
#get data of response
resp_json_reporte <- resp_get |> resp_body_json()

#check length or records
length(resp_json_reporte$data)

#get the record of the last observation so we can request it

resp_headers(resp_get)
ultimo_record <- resp_headers(resp_get)$record_cursor

#request the second batch
request_get <- request(request_url_get) |>
  req_headers(
    Authorization = paste('Zoho-oauthtoken', access_token),
    record_cursor = ultimo_record,
    accept = 'application/json'
  )


resp_get2 <- request_get |> req_perform()

status2 <- resp_status(resp_get)
status2
resp_json_reporte2 <- resp_get2 |> resp_body_json()





my_report <- resp_json_reporte$data %>% do.call(rbind,.)

nrow(my_report)

resp_json_reporte$data[1]
resp_body_string(resp_get)
#if token expiro, create a new ===============================================
# if(status != 200){
#   
#   
#   access_token <- create_access_token()
#   
#   #Perform the request again
#   resp_get <- request_get |> req_perform()
#   resp_json_reporte <- resp_get |> resp_body_json()
#   
#   
#   
# }
# 
# if(status == 200){
#   
#   resp_json_reporte <- resp_get |> resp_body_json()
#   
#   
# }
# 
# 
# 
# 
