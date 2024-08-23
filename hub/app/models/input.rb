class Input < ApplicationRecord
  has_many :tallies, dependent: :nullify

  VALID_STATUSES = %w[live preview dead]
  validates :status, inclusion: { in: VALID_STATUSES }

  before_validation :set_default_status

  private
  def set_default_status
    self.status = "dead" if self.status.nil?
  end
end