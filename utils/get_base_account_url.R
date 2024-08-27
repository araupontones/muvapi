library(httr2)
#' @param location the server location of zoho creator account
#' @return the base account url
get_base_account_url <- function(location){
  #this page returns a json with all the locations
  req <- request('https://accounts.zoho.com/oauth/serverinfo')
  
  #perform the request
  resp <- req_perform(req)
  
  #get the response in json format
  server_info <- resp_body_json(resp)
  
  #return the base account url of this location
  server_info$locations[[registration_keys$location]]
  
  
}


