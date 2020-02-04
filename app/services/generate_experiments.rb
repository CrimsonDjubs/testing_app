class GenerateExperiments
  USERS_COUNT = 100

  def initialize(device_token:)
    @device_token = device_token
  end

  def call
    find_or_initialize_device
    return @device if @device.persisted?

    experiments.map do |experiment|
      device_numbers = redis_experiment(experiment.name).dup

      store_device(device_numbers, experiment)
    end

    @device
  end

  private

  attr_reader :device_token

  def find_or_initialize_device
    @device = Device.find_or_initialize_by(device_token: device_token)
  end

  def experiments
    Experiment.all
  end

  def store_device(device_numbers, experiment)
    experiment.options.each do |option|
      next if option_percent_riched?(device_numbers[option.id], option.percent)

      Device.transaction do
        device_numbers[option.id] += 1
        add_device_count
        Redis.current.set(experiment.name, device_numbers.to_json)
        DeviceOption.create(device_id: @device.id, option_id: option.id) if @device.save
      end
      break
    end
  end

  def option_percent_riched?(devices_count, option_percent)
    (devices_count.to_f / USERS_COUNT).to_f == (option_percent.to_f / 100).to_f
  end

  def redis_experiment(name)
    JSON.parse(Redis.current.get(name)).map { |id, value| [id.to_i, value] }.to_h
  end

  def add_device_count
    devices_count = Redis.current.get('devices_number').to_i
    devices_count = 0 if devices_count == USERS_COUNT
    devices_count += 1
    Redis.current.set('devices_number', devices_count).to_i
  end
end