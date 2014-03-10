class HomeController < ApplicationController
  def index
    @offer_count = Offer.count
  end
end
