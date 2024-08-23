class TallyColorChannel < ApplicationCable::Channel

  def subscribed
    stream_for Tally.find(params[:tally_id])
  end

  def unsubscribed
  end
end
