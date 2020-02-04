# frozen_string_literal: true

class Experiment < ApplicationRecord
  has_many :options
end