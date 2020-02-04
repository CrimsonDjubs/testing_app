# frozen_string_literal: true

class Option < ApplicationRecord
  belongs_to :experiment

  has_many :device_options
  has_many :devices, through: :device_options

  after_create :add_default_device_numbers

  def add_default_device_numbers
    experiment_number = Redis.current.get(self.experiment.name)
    default_number = { id => 0 }

    default_number = default_number.merge(JSON.parse(experiment_number)) if experiment_number.present?

    Redis.current.set(self.experiment.name, default_number.to_json)
  end

  def self.temp_delete
    Option.destroy_all
    Experiment.destroy_all
    Device.destroy_all
    DeviceOption.destroy_all
    Redis.current.del('price', 'button_color')
  end
end