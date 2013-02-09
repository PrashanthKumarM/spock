# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Freshsurvey_session',
  :secret      => '9e37de2ed88c1bb48e3275ff763f9b10a09bd46f3ff3e28eb1b65975ac2947c30937a6da2b030c0f52350444f3298953613b105417390def3c23591fd852ac1c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
