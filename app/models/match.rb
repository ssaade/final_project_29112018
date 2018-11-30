class Match < ApplicationRecord
  # Direct associations

  belongs_to :sender_slot,
             :class_name => "Slot",
             :counter_cache => :sent_matches_count

  # Indirect associations

  # Validations

end
