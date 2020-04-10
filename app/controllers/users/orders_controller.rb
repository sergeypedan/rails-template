module Users
  class OrdersController < ApplicationController

    layout 'users_application'
    before_action :authenticate_user!

    def index
      @orders = current_user.orders
    end

  end
end
