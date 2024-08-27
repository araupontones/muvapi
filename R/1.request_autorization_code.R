
#'request authorization code
#'https://www.zoho.com/creator/help/api/v2.1/authorization-request.html
#'Firt create register a client in the API console


# Parameters ==================================================================
user <- 'pulpodata'

scope <- 'ZohoCreator.report.READ'
redirect_uri <- 'https://andresarau.com/'

# define request url ==========================================================
request_url <- glue('https://accounts.zoho.com/oauth/v2/auth?response_type=code&client_id={client_id}&scope={scope}&redirect_uri={redirect_uri}&access_type=offline')
request_url

#paste the code in the browser and follow the instructions

# I receive this code

# https://andresarau.com/?code=1000.493e96af2bf8353a358756229a249087.d8b43b26c2fa9a223bed8e042e2afdc1&location=us&accounts-server=https%3A%2F%2Faccounts.zoho.com

# Based on https://www.zoho.com/creator/help/api/v2.1/authorization-request.html


#define secret keys ============================================================
secret_keys <- list(
  client_id = client_id,
  client_secret = client_secret
)

# define registration keys =====================================================
registration_keys <- list(
authorization_code = '1000.6731a03a22cbc20f573d88985d908913.9b53c3b57add8532dcf9b8d8b9aee575',
location = 'us',
accounts_server = 'https%3A%2F%2Faccounts.zoho.com',
base_url = 'www.zohoapis.com',
redirect_uri = redirect_uri
)


#define the base account (function created in utils)
base_account_url <- get_base_account_url(registration_keys$location)

export(secret_keys, 'vault/secret_keys.rds')
export(registration_keys, 'vault/registration_keys.rds')
export(base_account_url, 'vault/base_account_url.rds')

