class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :parcel

  STATUS = %w(NEW IN OUT DEL)
  validates :user, presence: true
  validates :parcel, presence: true
  validates :description, inclusion: {in: STATUS}
end
