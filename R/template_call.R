#define request URL parameters

base_url 
account_owner_name
app_link_name
report_link_name


#define request URL
req_url <- glue('https://<base_url>/creator/v2.1/data/<account_owner_name>/<app_link_name>/report/<report_link_name>')

# create a request
req <- request(req_url)

# add HTTP headers to the request

req |> req_headers(
  
  Authorization, #authtoken
  environment, #?
  demo_user_name,
  record_cursor, #header key to fetch the next batch will be received in the response
  accept  = 'application/json' #but test later with 'text/csv'
  
  
) 

# add parameters 

req |> req_url_query(
  
  
)

# perform request

resp <- req |> req_perform()

#req_method() although define automatically, it can be customized