class TestsController < ActionController::API
  def index
    device = GenerateExperiments.new(device_token: device_token).call
    experiments = ExperimentsQuery.new(device).call
    experiment_options = ExperimentOptionPresenter.new(experiments).call
    render json: experiment_options, status: :ok
  end

  private

  def device_token
    request.headers['Device-Token']
  end
end