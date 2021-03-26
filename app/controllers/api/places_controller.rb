class Api::PlacesController < ApplicationController
  def index
    @places = Place.all
    render "index.json.jb"
  end

  def create
    @place = Place.new(
      name: params[:name],
      address: params[:address],
    )
    if @place.save
      render "show.json.jb"
    else
      render json: { errors: @place.errors.full_messages }, status: 406
    end
  end

  def show
    place_id = params[:id]
    @place = Place.find(place_id)

    render "show.json.jb"
  end

  def update
    place_id = params[:id]
    @place = Place.find(place_id)

    @place.name = params[:name] || @place.name
    @place.address = params[:address] || @place.address

    if @place.save
      render "show.json.jb"
    else
      render json: { errors: @place.errors.full_messages }, status: 406
    end
  end

  def destroy
    place_id = params[:id]
    @place = Place.find(place_id)

    if @place.destroy
      render json: { message: "Successfully destroyed" }
    else
      render json: { errors: @place.errors.full_messages }, status: 406
    end
  end
end
