class ApplicationController < ActionController::Base
  def switcher_simulator
    @inputs = Input.all
  end
end
