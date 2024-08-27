#' refresh access token. 
#' @description
#' The access token expires every 3,600 seconds. Thus, the access most be refreshed...
#' @returns the access token to request actions from the Zoho server

#load dependencies =============================================================

#load secrets and server info (only the admin could provide this)
gmdacr::load_functions('vault/')


create_access_token <- function(){

#the function only runs if secrets and server info have been provided to the user

for(file in c('secrets', "server_info")) {
  
  file_path <- glue('vault/{file}.R')
  
  if(!file.exists(file_path)) {
    
    cli::cli_abort(glue("File {file_path} is not found. Inform the admin"))
    
  }
}


#1. create request url =========================================================
  
#these parameters are saved in the 'vault'- ask project admin to access this folder
base_accounts_url <- server_info()$base_accounts_url
base_url <- server_info()$base_url 
refresh_token <- secrets()$refresh_token
client_id <- secrets()$client_id
client_secret <- secrets()$client_secret

## define url ------------------------------------------------------------------
request_url_refresh  <- glue('{base_accounts_url}/oauth/v2/token?refresh_token={refresh_token}&client_id={client_id}&client_secret={client_secret}&grant_type=refresh_token')

#create request
req <- request(request_url_refresh) |>
  req_method('POST')


## Check the request-----------------------------------------------------------
#req_dry_run(req)

# 2.Perform request===========================================================

# get access token : remember that expires every 3,600 segundos

resp <- req |> req_perform()

resp_json <- resp_body_json(resp)

## report to user the status of the request ------------------------------------
status <- resp_status(resp)
status_desc = httr2::resp_status_desc(resp)

## abort if there's an error with the request ------------------------------------
if(status != 200){
  
  cli::cli_abort(status_desription)
  
} 

## return access token if success ----------------------------------------------
if(status == 200){
  
  cli::cli_alert_success(status_desc)
  
  access_token <- resp_json$access_token
  return(access_token)
  
}



}
