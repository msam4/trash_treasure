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
    name: 'Registered',
    description: "Made an account!",
    custom_fields: { image: "badges/just-registered.png"}
  }, {
    id: (badge_id = badge_id+1),
    name: 'Toss first trash',
    description: "You toss away your first trash!",
    custom_fields: { image: "badges/first-toss.png" }
  }, {
    id: (badge_id = badge_id+1),
    name: 'Add a new place',
    description: "You add a new place!",
    custom_fields: { image: "badges/add-a-new-place.png" }
  }, {
    id: (badge_id = badge_id+1),
    name: 'Add a new bin',
    description: "You add a new bin!",
    custom_fields: { image: "badges/add-new-bin.png" }
  }, {
    id: (badge_id = badge_id+1),
    name: 'Toss 5 pieces',
    description: "You toss away 5 pieces of trash!",
    custom_fields: { image: "badges/toss-5-pieces.png" }
  }, {
    id: (badge_id = badge_id+1),
    name: 'Toss 10 pieces',
    description: "You toss away 10 pieces of trash!",
    custom_fields: { image: "badges/toss-10-pieces.png" }
  }, {
    id: (badge_id = badge_id+1),
    name: 'Add 5 new places',
    description: "You add 5 new places!"
    custom_fields: { image: "badges/add-5-new-places.png" }
  }, {
    id: (badge_id = badge_id+1),
    name: 'Add 10 new places',
    description: "You add 10 new places!"
    custom_fields: { image: "badges/add-10-new-places.png" }
  }].each do |attrs|
    Merit::Badge.create! attrs
  end
end
