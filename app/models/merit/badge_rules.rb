# Be sure to restart your server when you modify this file.
#
# +grant_on+ accepts:
# * Nothing (always grants)
# * A block which evaluates to boolean (recieves the object as parameter)
# * A block with a hash composed of methods to run on the target object with
#   expected values (+votes: 5+ for instance).
#
# +grant_on+ can have a +:to+ method name, which called over the target object
# should retrieve the object to badge (could be +:user+, +:self+, +:follower+,
# etc). If it's not defined merit will apply the badge to the user who
# triggered the action (:action_user by default). If it's :itself, it badges
# the created object (new user for instance).
#
# The :temporary option indicates that if the condition doesn't hold but the
# badge is granted, then it's removed. It's false by default (badges are kept
# forever).

module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods

    def initialize
      # If it creates user, grant badge
      # Should be "current_user" after registration for badge to be granted.
      # Find badge by badge_id, badge_id takes presidence over badge
      # grant_on 'users#create', badge_id: 7, badge: 'just-registered', to: :itself

      grant_on 'devise/registrations#create', badge: 'just-registered' do
        true
      end

      # When the user arrives a bin"
      grant_on 'tosses#create', badge: 'first-toss',
        to: :user do |toss|
        # Add condition for arriving at a bin
        toss.user.tosses.count >= 1
      end

      grant_on 'tosses#create', badge: 'toss-5-trashes',
        to: :user do |toss|
        # Add condition for arriving at 5 places
        toss.user.tosses.count >= 5
      end

      grant_on 'tosses#create', badge: 'toss-10-trashes',
        to: :user do |toss|
        # Add condition for arriving at 10 places
        toss.user.tosses.count >= 10
      end

      # When the user adds a new place
      grant_on 'places#create', badge: 'add-a-new-place',
        to: :user do |place|
        # Add condition for adding a new place
          place.user.places.count >= 1
      end

      grant_on 'places#create', badge: 'add-5-new-places',
        to: :user do |place|
        # Add condition for creating 5 new places
        place.user.places.count >= 5
      end

      grant_on 'places#create', badge: 'add-10-new-places',
        to: :user do |place|
        # Add condition for creating 10 new places
        place.user.places.count >= 10
      end

      grant_on 'trash_bins#create', badge: 'add-a-new-bin',
        to: :user do |bin|
        # Add condition for adding a new bin
        bin.user.trash_bin.count >= 1
      end

    end
  end
end
