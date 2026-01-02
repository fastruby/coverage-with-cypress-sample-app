class User < ApplicationRecord
  validates :name, :lastname, presence: true
end
