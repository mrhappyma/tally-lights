class TalliesController < ApplicationController
  def index
    @tallies = Tally.all
    @statuses = TallyStatusChannel.connected_tallies
  end

  def new
    @tally = Tally.new
  end

  def create
    Tally.create(tally_params)
    redirect_to tallies_path
  end

  def edit
    @tally = Tally.find(params[:id])
  end

  def update
    Tally.find(params[:id]).update(tally_params)
    redirect_to tallies_path
  end

  def destroy
    Tally.find(params[:id]).destroy
    redirect_to tallies_path
  end

  def switch
    tally = Tally.find(params[:id])
    tally.update(on: !tally.on)
    TallyStatusChannel.broadcast_to(tally, tally.on)
    redirect_to tallies_path
  end

  def on
    tallies = Tally.where(on: true).pluck(:id)
    render json: tallies
  end

  private
  def tally_params
    params.require(:tally).permit(:name, :input_id)
  end
end
