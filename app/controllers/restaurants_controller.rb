class RestaurantsController < ApplicationController
    def index
        @restaurants = Restaurant.all
        @menu_items = MenuItem.all
    end

    def show
        @restaurant = Restaurant.find(params[:id])
    end

    def new
        if can? :manage, Restaurant
            @restaurant = Restaurant.new
        else
            flash[:error] = "No permission!"
        end
    end

    def create
        if current_user.admin? or (current_user.vendor? and current_user.restaurant.nil?)
            @restaurant = Restaurant.new(params[:restaurant])
            if @restaurant.save
                flash[:success] = "Restaurant successfully created"
                redirect_to @restaurant
            else
                flash[:error] = "Something went wrong"
                render 'new'
            end
        else
            flash[:error] = "No permission!"
        end
    end

    def destroy
        if current_user.admin?
            @restaurant = Restaurant.find(params[:id])
            if @restaurant.destroy
                flash[:success] = 'Restaurant was successfully deleted.'
                redirect_to restaurants_url
            else
                flash[:error] = 'Something went wrong'
                redirect_to restaurants_url
            end
        else
            flash[:error] = "No permission!"
        end
    end
end
