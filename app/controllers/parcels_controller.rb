class ParcelsController < ApplicationController
  before_action :set_parcel, only: [:show, :edit, :update, :preview]

  def new
    @parcel = Parcel.new
    @pudo_list = User.where(pudo: "true")
    authorize @parcel
  end

  def create
    @parcel = Parcel.new(parcel_params)
    @parcel.origin = current_user
    @parcel.owner = current_user
    # @parcel.code = "wagon"
    authorize @parcel
    if @parcel.save
        @parcel.touch
       redirect_to parcel_path(@parcel), notice: "The parcel #{@parcel.id} has been created."
     else
       render "new"
    end
  end

  def edit
    @pudo_list = User.where(pudo: "true")
  end

  def update

    @parcel.update(parcel_params)
    authorize @parcel
    if @parcel.save
      redirect_to parcel_path(@parcel), notice: "The parcel #{@parcel.id} has been updated."
    else
      render :edit
    end
  end

  def show
    authorize @parcel
  end

  def decode
    @data = params[:data]
    @parcel = Parcel.last
    authorize @parcel
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def preview
    @qr = RQRCode::QRCode.new(@parcel.code, :size => 4, :level => :h )
  end

  private

  def set_parcel
    @parcel = Parcel.find(params[:id])
    authorize @parcel
  end

  def parcel_params
    params.require(:parcel).permit(:sender_first_name, :sender_last_name, :sender_phone, :receiver_first_name, :receiver_last_name, :receiver_phone, :destination_id)
  end
end
