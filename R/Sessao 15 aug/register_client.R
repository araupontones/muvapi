library(glue)
library(httr2)




scope <- 'ZohoCreator.report.READ'
redirect_uri <- 'https://andresarau.com/'

request_url <- glue('https://accounts.zoho.com/oauth/v2/auth?response_type=code&client_id={client_id}&scope={scope}&redirect_uri={redirect_uri}&access_type=offline')

request_url
#URL recieved


#https://andresarau.com/?code=1000.c46d91f82a83f972df7f62405699802c.66c9ec0d3e04121d544dc6f849c22571&location=us&accounts-server=https%3A%2F%2Faccounts.zoho.com&
  
  
authorization_code <- '1000.ab669c97d223e345e7941ef8feb3bed4.6d58cdaee1312f91055352c7c82f19dc'
location <- 'us'
account_server <- 'https%3A%2F%2Faccounts.zoho.com'

#2. Generate access token

#to know which is your base_account_url go to: https://accounts.zoho.com/oauth/serverinfo
base_accounts_url <- 'https://accounts.zoho.com'


request_url_access <- glue('{base_accounts_url}/oauth/v2/token?grant_type=authorization_code&client_id={client_id}&client_secret={client_secret}&redirect_uri={redirect_uri}&code={authorization_code}')

request_url_access
#Define the request
req <- request(request_url_access) |>
  req_method('POST')

#Check the request
req_dry_run(req)

#perform the request
resp <- req |> req_perform()

resp_json <- resp_body_json(resp)

#save responses 
access_token <- resp_json$access_token
refresh_token <- resp_json$refresh_token
api_domain <- resp_json$api_domain


