# frozen_string_literal: true

class ParksController < ApplicationController
  skip_before_action :authorized

  def show
    park = Park.find(params[:id])
    render json: park, status: :ok
  end

  def index
    if params[:query] == 'Others'
      parks = Park.others
    else
      query = params[:query]&.gsub('+', ' ')
      parks = query ? Park.designation_select(query) : Park.designation_select
    end
    render_parks = []
    parks.each do |p|
      park = ParkSerializer.new(p).attributes
      park[:pictures] = Array(park[:pictures]).sample
      render_parks << park
    end
    render json: render_parks, status: :ok
  end
end
