#' Generates access token and refresh token
#' @return request url to generate access_token and refresh token


req_url_tokens <- function(base_accounts_url,
                           client_id,
                           client_secret,
                           redirect_uri,
                           authorization_code
){
  
  glue('{base_accounts_url}/oauth/v2/token?grant_type=authorization_code&client_id={client_id}&client_secret={client_secret}&redirect_uri={redirect_uri}&code={authorization_code}')
  
}
