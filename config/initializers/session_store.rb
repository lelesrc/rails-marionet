# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rails-marionet_session',
  :secret      => '7f65053d2a902fe2faee9347f974153ce0f9bec8092d45d23c0beaad8e72d7a15d098f7b321a99275956b7b3c23f3092230601422fee884a4a834ed8b2c1bb26'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
