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

  def receiver_full_name
    "#{self.receiver_first_name.capitalize} #{self.receiver_last_name.capitalize}"
  end
end
