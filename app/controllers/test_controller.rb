class TestController < ApplicationController
  before_action :authenticate_user!, only: :new

  def index
    @images = Image.all
  end

  def new
    @images = Image.all
  end

end
