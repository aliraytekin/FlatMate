class PagesController < ApplicationController
  # skip_after_action :verify_policy_scoped
  # skip_after_action :verify_authorized
  skip_before_action :authenticate_user!, only: :home

  def home
    @offers = Offer.all
  end
end
