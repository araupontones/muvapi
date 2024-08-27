#' Generate Access Token and Refresh Token
#' Based on https://www.zoho.com/creator/help/api/v2.1/generate-token.html
#' @param request_url request url as it is indicated in the zoho api documentation
#' @return a list with {access_token, refresh_token, api_domain, token_domain, expires_in}
generate_tokens <- function(request_url){
  
  #define request --------------------------------------------------------------
  req <- request(request_url) |>
    req_method('POST')
  
  
  # perform request ------------------------------------------------------------
  
  resp <- req_perform(req)
  
  #check status
  status <- resp_status(resp)
  
  if(status == 200){
    
   print(resp_body_json(resp))
    cli::cli_alert_success("Access token and refresh tokens have been generted")
    return(resp_body_json(resp))  
    
  } 
   
}
