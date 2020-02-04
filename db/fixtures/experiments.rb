# frozen_string_literal: true

Experiment.seed(:id, { name: 'button_color' }, { name: 'price' })

Option.seed(:id,
  { experiment_id: Experiment.first.id, percent: 33.3, value: '#FF0000' },
  { experiment_id: Experiment.first.id, percent: 33.3, value: '#00FF00' },
  { experiment_id: Experiment.first.id, percent: 33.3, value: '#0000FF' },
  { experiment_id: Experiment.last.id, percent: 75, value: '10' },
  { experiment_id: Experiment.last.id, percent: 10, value: '20' },
  { experiment_id: Experiment.last.id, percent: 5,  value: '50' },
  { experiment_id: Experiment.last.id, percent: 10, value: '5' }
)

100.times do
  GenerateExperiments.new(device_token: SecureRandom.hex).call
end
