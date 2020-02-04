class StatisticsController < ApplicationController
  def index
    @experiments = ExperimentStatisticsQuery.new.call
  end
end