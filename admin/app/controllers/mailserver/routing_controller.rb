class Mailserver::RoutingController < ApplicationController

  def index
    @routes = Routing.find(:all)
  end

  def create
    @route = Routing.new
    @route.attributes = params[:route]
    @route.save
  end

  def delete
    @route = Routing.find params[:id]
    @route.destroy
  end

end
