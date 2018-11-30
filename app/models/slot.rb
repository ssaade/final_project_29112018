class Slot < ApplicationRecord
  # Direct associations

  has_many   :received_matches,
             :class_name => "Match",
             :foreign_key => "recipient_slot_id",
             :dependent => :destroy

  has_many   :sent_matches,
             :class_name => "Match",
             :foreign_key => "sender_slot_id",
             :dependent => :destroy

  belongs_to :user,
             :counter_cache => true

  # Indirect associations

  # Validations

end
