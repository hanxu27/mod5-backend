# frozen_string_literal: true

class TripsController < ApplicationController
  def index
    # page = params[:page] || 1
    @pagy, @trips = pagy_array(Trip.all.sort_by { |t| t['updated_at'] }.reverse)
    render json: @trips, status: :ok
  end

  def show
    trip = Trip.find(params[:id])
    render json: trip, status: :ok
  end

  def create
    trip = Trip.new(s_params)
    if trip.save
      render json: trip, status: :created
    else
      render json: trip.erros.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    trip = Trip.find(params[:id])
    trip.destroy
    render json: trip, status: :ok
  end

  private

  def s_params
    params.require(:trip).permit(:user_id, :park_id, :title, :description, :season, :year)
  end
end
