# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_consensus_session',
  :secret      => 'f3912a82bac535cba19ce4436fe57fb979e611f3cea86438d9e17b397b576c80229182802ce7b349fa04e1429bf70f96d9ea7ebe74f7abc60ff0eb253e2d24c3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
