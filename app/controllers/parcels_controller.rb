require 'base64'

class ParcelsController < ApplicationController
  before_action :set_parcel, only: [:show, :edit, :update, :preview, :become_owner, :retrieve_owner]

  def new
    @parcel = Parcel.new
    @pudo_list = User.where(pudo: true).where.not(id: current_user.id)
    authorize @parcel
  end

  def create
    @parcel = Parcel.new(parcel_params)
    @parcel.origin = current_user
    @parcel.owner = current_user
    authorize @parcel
    if @parcel.save
        @event_crea = Event.new({user: current_user, parcel: @parcel, description: "NEW"})
        @event_crea.save
       redirect_to parcel_path(@parcel), notice: "Le colis a été créé avec succès."
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
      redirect_to parcel_path(@parcel), notice: "Le colis a été mis à jour."
    else
      render :edit
    end
  end

  def show
    authorize @parcel
  end

  def decode
    @data = params[:data]
    @info = retrieve_info_qr(@data)
    @parcel = Parcel.last
    authorize @parcel
    if @info
      match_data = @info.match(/^(\w+);(\w+);$/)
      @parcel = Parcel.find(match_data[1].to_i)
      authorize @parcel
    end
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def become_owner
    # Reprise de l'ownership du parcel et creation de l'evenement correspondant
    authorize @parcel
    if @parcel.owner == nil
      @parcel.owner = current_user
      # Regeneration d'un code aléatoire
      @parcel.code = rand(1000..9999)
      @parcel.save
      Event.create!({user: current_user, parcel: @parcel, description: "IN"})
      flash[:notice] = "Vous êtes le nouveau propriétaire du colis"
    else
    # alert negative
      flash[:alert] = "Transfert non validé. Veuillez recommencer et attendre la validation "
    end
    redirect_to root_path
  end

  def retrieve_owner
    # Abandon de l'ownership
    @parcel.owner = nil
    @parcel.save
    if @parcel.destination_id == current_user.id
      Event.create!({user: current_user, parcel: @parcel, description: "DEL"})
    else
      Event.create!({user: current_user, parcel: @parcel, description: "OUT"})
    end
    authorize @parcel
    redirect_to root_path
  end

  def preview
    @qr = RQRCode::QRCode.new(@parcel.encode_qr, :size => 4, :level => :h )
  end

  private

  def set_parcel
    @parcel = Parcel.find(params[:id])
    authorize @parcel
  end

  def parcel_params
    params.require(:parcel).permit(:sender_first_name, :sender_last_name, :sender_phone, :receiver_first_name, :receiver_last_name, :receiver_phone, :destination_id)
  end

  require 'open-uri'
  require 'nokogiri'

  def retrieve_info_qr(data)
      #J'upload la photo sous format base64 et elle se met en PNG sur cloudinary
      photo_hash = Cloudinary::Uploader.upload(data)
      current_user.photo = photo_hash['url']
      current_user.save
      # J'enregistre en base l'url de la photo
      url_test = current_user.photo
      # Scraping du resultat en envoyant l'url de la photo sur le site de decode
      html_file = open("https://zxing.org/w/decode?u=#{url_test}")
      html_doc = Nokogiri::HTML(html_file)
      if html_doc.css("/html/body/div/table/tr[1]/td[2]/pre").empty?
        return nil
      else
        return html_doc.css("/html/body/div/table/tr[1]/td[2]/pre").text
      end
  end
end
