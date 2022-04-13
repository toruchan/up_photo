class Plan < ApplicationRecord

  has_many :user
  
  enum period: { monthly: 0, yearly: 1 }
  
end
