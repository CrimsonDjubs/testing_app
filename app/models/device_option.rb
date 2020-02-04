# frozen_string_literal: true

class DeviceOption < ApplicationRecord
  belongs_to :option
  belongs_to :device
end