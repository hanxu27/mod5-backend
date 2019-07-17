# frozen_string_literal: true

require 'pagy/extras/array'

class ApplicationController < ActionController::API
  include Pagy::Backend
end
