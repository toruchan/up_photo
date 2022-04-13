class Inquiry < ApplicationRecord

  validates :name, presence: true
  validates :email, presence: true
  validates :detail, presence: true
end
