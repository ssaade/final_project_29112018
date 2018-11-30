class Match < ApplicationRecord
  # Direct associations

  has_many   :comments,
             :dependent => :destroy

  belongs_to :recipient_slot,
             :class_name => "Slot",
             :counter_cache => :received_matches_count

  belongs_to :sender_slot,
             :class_name => "Slot",
             :counter_cache => :sent_matches_count

  # Indirect associations

  has_one    :receiving_user,
             :through => :recipient_slot,
             :source => :user

  # Validations

end
