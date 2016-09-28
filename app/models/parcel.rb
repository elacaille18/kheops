class Parcel < ActiveRecord::Base
  #Associations
  belongs_to :owner, class_name: "User"
  belongs_to :origin, class_name: "User"
  belongs_to :destination, class_name: "User"

  has_many :events
  #has_many :users, through: :events


  # #Validations
  # validates :user, presence: true
  # validates :description, presence: true
end
