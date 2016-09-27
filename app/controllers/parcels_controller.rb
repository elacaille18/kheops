class ParcelsController < ApplicationController
  before_action :set_parcel, only: [:show, :edit, :update]

  def new
    @parcel = Parcel.new
    authorize @parcel
  end

  def create
    @parcel = Parcel.new(parcel_params)

    authorize @parcel
    if @parcel.save
        @parcel.touch
       redirect_to mission_path(@mission), notice: "The parcel #{@parcel.description} has been created."
       render "new"
    end
  end

  def edit
  end

  def update

    @parcel.update(parcel_params)
    authorize @parcel
    if @parcel.save
      redirect_to parcel_path(@parcel), notice: "The parcel #{@parcel.description} has been updated."
    else
      render :edit
    end
  end

  def show
    authorize @parcel
  end

  private

  def set_parcel
    @parcel = Parcel.find(params[:id])
    authorize @parcel
  end

  def parcel_params
    params.require(:parcel).permit(:description, :code)
  end
end
