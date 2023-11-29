# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'MyObserverClassName'

  # Define :user_model_name. This model will be used to grant badge if no
  # `:to` option is given. Default is 'User'.
  # config.user_model_name = 'User'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
  # config.current_user_method = 'current_user'

  def badges
  end
end

# Create application badges (uses https://github.com/norman/ambry)
Rails.application.reloader.to_prepare do
  badge_id = 0
  [{
    id: (badge_id = badge_id+1),
    name: 'just-registered'
  }, {
    id: (badge_id = badge_id+1),
    name: 'first-toss'
  }, {
    id: (badge_id = badge_id+1),
    name: 'add-a-new-place'
  }, {
    id: (badge_id = badge_id+1),
    name: 'add-a-new-bin'
  }, {
    id: (badge_id = badge_id+1),
    name: 'toss-5-trashes'
  }, {
    id: (badge_id = badge_id+1),
    name: 'toss-10-trashes'
  }, {
    id: (badge_id = badge_id+1),
    name: 'create-5-new-places'
  }, {
    id: (badge_id = badge_id+1),
    name: 'create-10-new-places'
  }].each do |attrs|
    Merit::Badge.create! attrs
  end
end
