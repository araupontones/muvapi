#'generate tokens
#' https://www.zoho.com/creator/help/api/v2.1/generate-token.html
#'

gmdacr::load_functions('utils/')
#import parameters ==============================================================
base_account_url <- get_base_account_url(location = 'us')
#THESE ARE DEFINED IN 1.request_authorization_code.R
secret_keys <- import('vault/secret_keys.rds')
registration_keys <- import('vault/registration_keys.rds')



#this url returns the access_token, refresh token and the time that it expires on
request_url <- req_url_tokens(base_account_url,
               client_id = secret_keys$client_id,
               client_secret = secret_keys$client_secret,
               redirect_uri = registration_keys$redirect_uri,
               authorization_code = registration_keys$authorization_code
               )

request_url
#get request ================================================================
#fetch access_token and refresh token
tokens <- generate_tokens(request_url) #function defined in utils



export(tokens$,'vault/refresh_token.rds')

#Access tokens expire in an hour, clients must use the refresh token to generate another access_token
