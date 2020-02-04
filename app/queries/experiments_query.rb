# frozen_string_literal: true

class ExperimentsQuery
  def initialize(device)
    @device = device
  end

  def call
    device.options.includes(:experiment)
  end

  private

  attr_reader :device
end