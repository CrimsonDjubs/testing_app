# frozen_string_literal: true

require 'rails_helper'

describe TestsController, type: :controller do
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

  it 'response ok' do
    request.headers.merge!('Device-Token' => 'new')
    get :index

    expect(response.code).to eq '200'
    expect(JSON.parse(response.body)).to eq(
      'button_color' => '#FF0000',
      'price' => '10'
    )
  end
end
