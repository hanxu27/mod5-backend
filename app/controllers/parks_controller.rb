# frozen_string_literal: true

class ParksController < ApplicationController
  skip_before_action :authorized

  def show
    park = Park.find(params[:id])
    render json: park, status: :ok
  end

  def index
    params[:query] ? parks = Park.designation_select(params[:query]) : parks = Park.designation_select
    render_parks = []
    parks.each do |p|
      park = ParkSerializer.new(p).attributes
      park[:pictures] = Array(park[:pictures]).sample
      render_parks << park
    end
    render json: render_parks, status: :ok
  end
end
