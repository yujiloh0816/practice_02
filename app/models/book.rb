class Book < ApplicationRecord

  #Validates
  validates :title, presence: true
  validates :body, presence: true


end
