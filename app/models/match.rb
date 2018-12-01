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

  has_one    :sending_user,
             :through => :sender_slot,
             :source => :user

  has_one    :receiving_user,
             :through => :recipient_slot,
             :source => :user

  # Validations
  validates :sender_slot_id, presence: true
  validates :recipient_slot_id, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  
  validate :date_cannot_be_in_the_past,
 
  def date_cannot_be_in_the_past
    if date < Date.today
      errors.add(:date, "Date can't be in the past")
    end
  end

  
  validate :two_hours_min,
 
  def two_hours_min
    if ( end_time - start_time) < 7200
      errors.add(:end_time, "End time cannot be less than 2 hours after start time")
    end
  end
end
