class HomeController < ApplicationController
  def index
  end

  def comments
    render json: [
      {author:"Pete Hunt", text: "This is one comment"},
      {author:"Jordan Walke", text: "This is *another* comment"},
    ]
  end
end
