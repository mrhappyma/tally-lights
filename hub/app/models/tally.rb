class Tally < ApplicationRecord
  belongs_to :input, optional: true

  before_validation :set_default_on

  private
  def set_default_on
    self.on = false if self.on.nil?
  end
end