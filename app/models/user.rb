class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #mount_uploader :photo, PhotoUploader
  #attr_accessor :photo

  #Asssociations
  has_many :events
  has_many :parcels
end
