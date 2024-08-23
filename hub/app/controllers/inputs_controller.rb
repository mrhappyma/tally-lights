class InputsController < ApplicationController
  def index
    @inputs = Input.all
  end

  def new
    @input = Input.new
  end

  def create
    Input.create(input_params)
    redirect_to inputs_path
  end

  def edit
    @input = Input.find(params[:id])
  end

  def update
    Input.find(params[:id]).update(input_params)
    redirect_to inputs_path
  end

  def destroy
    Input.find(params[:id]).destroy
    redirect_to inputs_path
  end

  def set_status
    input = Input.find(params[:id])
    input.update(:status => params[:state])
    tallies = input.tallies
    tallies.each do |tally|
      case params[:state]
      when "live"
        TallyColorChannel.broadcast_to(tally, "0,15,0")
      when "preview"
        TallyColorChannel.broadcast_to(tally, "15,0,0")
      when "dead"
        TallyColorChannel.broadcast_to(tally, "0,0,0")
        end
    end
    render json: input
  end

  private
  def input_params
    params.require(:input).permit(:name)
  end
end
