require 'csv'

class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  # GET /offers
  # GET /offers.json
  def index
    @offers = Offer.all
  end

  # GET /offers/1
  # GET /offers/1.json
  def show
  end

  # GET /offers/new
  def new
    @offer = Offer.new
  end

  # GET /offers/1/edit
  def edit
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(offer_params)

    respond_to do |format|
      if @offer.save
        format.html { redirect_to @offer, notice: 'Offer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @offer }
      else
        format.html { render action: 'new' }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offers/1
  # PATCH/PUT /offers/1.json
  def update
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to offers_url }
      format.json { head :no_content }
    end
  end

  # POST /offers/upload
  def upload
    begin
      offers = parse_tsv(params[:file])
    rescue => e
      redirect_to(request.referrer, flash: { error: "Failed to parse TSV file" })
      return
    end

    Offer.transaction do
      begin
        offers.each do |offer|
          logger.debug "offer: #{offer.inspect}"
          Offer.create!(
            business_name: offer["name"],
            address_1: offer["address_1"],
            address_2: offer["address_2"],
            postal_code: offer["postal_code_name"],
            postal_code_suffix: offer["postal_code_suffix"],
            phone_number: offer["phone_number"],
            latitude: offer["latitude"],
            longitude: offer["longitude"],
            radius: offer["radius"]
          )
        end
      rescue => e
        redirect_to(request.referrer, flash: { error: "Failed to import data from TSV file: #{e.message}" })
        raise ActiveRecord::Rollback
      else
        redirect_to(offers_path, notice: "Successfully imported offers!")
      end
    end
  end

  # DELETE /offers/destroy_all
  def destroy_all
    Offer.delete_all

    redirect_to offers_path, notice: "Deleted all offers!"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_offer
    @offer = Offer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def offer_params
    params.require(:offer).permit(
      :business_name,
      :address_1,
      :address_2,
      :city,
      :state,
      :country,
      :postal_code,
      :postal_code_suffix,
      :phone_number,
      :latitude,
      :longitude,
      :radius
    )
  end

  # Parses TSV file, returning an array of hashes where
  # the keys are column names from first row
  def parse_tsv(file)
    begin
      tsv = CSV.parse(file.read, col_sep: "\t", converters: lambda {|f| f ? f.strip : nil})
      # assume the first row contains the column names
      cols = tsv.shift

      # create a hash for each row
      tsv.collect do |vals|
        Hash[cols.zip(vals)]
      end
    rescue => e
      logger.debug "failed to parse tsv file: #{e.message}"
      raise "parse error"
    end
  end
end
