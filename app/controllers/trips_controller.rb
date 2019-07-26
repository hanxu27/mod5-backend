# frozen_string_literal: true

class TripsController < ApplicationController
  skip_before_action :authorized, only: [:index]

  def index
    # page = params[:page] || 1
    sort_arr = %w[Spring Summer Fall Winter]
    @pagy, @trips = pagy_array(Trip.all.sort_by { |t| [t['year'], sort_arr.index(t['season'])] }.reverse)
    # @trips = Trip.all.sort_by { |t| [t['year'], sort_arr.index(t['season'])] }.reverse
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
      render json: { message: trip.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    trip = Trip.find(params[:id])
    if trip.update(s_params)
      render json: trip, status: :accepted
    else
      render json: { message: trip.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    trip = Trip.find(params[:id])
    if current_user.id == trip.user.id
      trip.destroy
      render json: trip, status: :ok
    else
      render json: { message: ['cannot delete trips that are not yours'] }, status: :unauthorized
    end
  end

  private

  def s_params
    params.require(:trip).permit(:user_id, :park_id, :title, :description, :season, :year)
  end
end
