class RodauthApp < Rodauth::Rails::App
  # primary configuration
  # Not needed yet
  # configure RodauthMain

  # secondary configuration
  configure RodauthAdmin, :admin

  route do |r|
    # rodauth.load_memory # autologin remembered users

    # r.rodauth
    r.rodauth(:admin)

    # authenticate /admin/* requests
    if r.path.start_with?("/admin")
      rodauth(:admin).require_account
    end
  end
end
