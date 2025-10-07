Rails.application.configure do
  # ... all your existing config above ...

  # Enable DNS rebinding protection and allow only your real domain
   config.hosts << "org.orgatroworkhub.xyz"
   config.hosts << /.*\.orgatroworkhub\.xyz/


  #config.hosts << "org.orgratroworkhub.xyz"
  
  
  # If you want to allow all hosts in production (not recommended):
  # config.hosts.clear
end
