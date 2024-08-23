class TallyStatusChannel < ApplicationCable::Channel
  @connected_tallies = {}

  class << self
    attr_accessor :connected_tallies
  end

  def subscribed
    stream_for Tally.find(params[:tally_id])
    self.class.connected_tallies[params[:tally_id]] = true
  end

  def unsubscribed
    self.class.connected_tallies.delete(params[:tally_id])
  end
end
