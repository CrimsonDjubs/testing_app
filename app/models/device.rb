# frozen_string_literal: true

class Device < ApplicationRecord
  has_many :device_options
  has_many :options, through: :device_options
end