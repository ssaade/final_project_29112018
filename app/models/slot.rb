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
 
  validates :user_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  
  validate :date_cannot_be_in_the_past,
 
  def date_cannot_be_in_the_past
    if start_time.present? && start_time < Time.now
      errors.add(:start_time, "cannot be in the past")
    end
  end
  
  validate :date_cannot_be_too_far,
 
  def date_cannot_be_too_far
    if start_time.present? && start_time > Time.now + 90*24*60*60
      errors.add(:start_time, "cannot be more than 3 months into the future")
    end
  end
  
  validate :two_hours_min,
 
  def two_hours_min
    if end_time.present? && start_time.present? && ( end_time - start_time) < 7200
      errors.add(:end_time, " cannot be less than 2 hours after start time")
    end
  end
  
  
end
