class Place < ApplicationRecord
  default_scope { order(created_at: :desc) }
  acts_as_taggable_on :tags
  belongs_to :user
end
