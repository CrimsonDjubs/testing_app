# frozen_string_literal: true

class ExperimentStatisticsQuery
  def call
    Experiment.includes(options: :devices)
  end
end