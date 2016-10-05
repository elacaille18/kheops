require 'qrio'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  #include HomeHelper

  def home
  end

  def input
  end

  def output
    @parcels = Parcel.all
  end

  def scanqr
    #@result = Qrio::Qr.load("/Users/ericlacaille/Desktop/exqrcode.png").qr.text
  end

  private

  def resource_name
    :user
  end
  helper_method :resource_name

  def resource
    @resource ||= User.new
  end
  helper_method :resource

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  helper_method :devise_mapping

  def resource_class
    User
  end
  helper_method :resource_class

end
