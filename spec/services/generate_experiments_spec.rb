# frozen_string_literal: true

require 'rails_helper'

describe GenerateExperiments do
  let!(:experiment1) { create :experiment, name: 'button_color' }
  let(:option1) { create :option, experiment: experiment1, percent: 33.3, value: '#FF0000' }
  let(:option2) { create :option, experiment: experiment1, percent: 33.3, value: '#00FF00' }
  let(:option3) { create :option, experiment: experiment1, percent: 33.3, value: '#0000FF' }

  let!(:experiment2) { create :experiment, name: 'price' }
  let(:option4) { create :option, experiment: experiment2, percent: 75, value: '10' }
  let(:option5) { create :option, experiment: experiment2, percent: 10, value: '20' }
  let(:option6) { create :option, experiment: experiment2, percent: 5,  value: '50' }
  let(:option7) { create :option, experiment: experiment2, percent: 10, value: '5' }

  before do
    Redis.current.set('button_color', { option1.id => 0, option2.id => 0, option3.id => 0 }.to_json)
    Redis.current.set('price', { option4.id => 0, option5.id => 0, option6.id => 0, option7.id => 0 }.to_json)
  end

  it do
    100.times do
      described_class.new(device_token: SecureRandom.hex).call
    end
    expect(Redis.current.get('button_color')).to eq({ option1.id => 33, option2.id => 33, option3.id => 33 }.to_json)
    expect(Redis.current.get('price')).to eq({ option4.id => 75, option5.id => 10, option6.id => 5, option7.id => 10 }.to_json)
  end
end