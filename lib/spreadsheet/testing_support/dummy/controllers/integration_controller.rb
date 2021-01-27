class IntegrationController < ApplicationController
  def show
    render "#{params[:component]}_component_test"
  end
end
