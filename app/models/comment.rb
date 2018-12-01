class Comment < ApplicationRecord
  # Direct associations

  belongs_to :match,
             :counter_cache => true

  belongs_to :author,
             :class_name => "User",
             :counter_cache => true

  # Indirect associations

  # Validations
  validates :author_id, presence: true
  validates :match_id, presence: true
  validates :body, presence: true

end
