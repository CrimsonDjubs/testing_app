# frozen_string_literal: true

class ExperimentOptionPresenter
  def initialize(options)
    @options = options
  end

  def call
    options.map do |option|
      [option.experiment.name, option.value]
    end.to_h
  end

  private

  attr_reader :options
end