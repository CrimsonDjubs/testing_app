# frozen_string_literal: true

FactoryBot.define do
  factory :option do
    experiment
    value { 'test_value' }
    percent { 0 }
  end
end