class RestaurantsController < ApplicationController
    before_action :set_appointment, only: [:show, :edit, :update, :destroy]

    def by_city
        @restaurants_cities = Restaurant.joins(:branches).where(branches: {city: "#{params[:city]}"}).uniq
    end
    
    def index
        @restaurants = Restaurant.all
        @menu_items = MenuItem.all
        cities_arr = []
        @restaurants.each {|r| puts r.branches.each { |b| puts cities_arr << b.city}}
        @branches_by_cities = cities_arr.uniq!
    end

    def show
    end

    def new
        if can? :create, Restaurant
            @restaurant = Restaurant.new
        else
            flash[:error] = "No permission!"
        end
    end

    def create
        if can? :create, Restaurant
            @restaurant = Restaurant.new(restaurant_params)
            @restaurant.user_id = current_user.id
            
            if @restaurant.save
                flash[:success] = "Restaurant successfully created"
                redirect_to @restaurant
            else
                flash[:error] = "Something went wrong"
                redirect_to new_restaurant_path
            end
        else
            flash[:error] = "No permission!"
        end
    end

    def edit
        if !can? :update, @restaurant
            flash[:error] = "Something went wrong"
            redirect_to @restaurant
        end
    end
    

    def update
        if @restaurant.update(restaurant_params)
          flash[:success] = "Restaurant was successfully updated"
          redirect_to @restaurant
        else
          flash[:error] = "Something went wrong"
          redirect_to edit_restaurant_path
        end
    end
    

    def destroy
        if current_user.admin?
            if @restaurant.destroy
                flash[:success] = 'Restaurant was successfully deleted.'
                redirect_to @restaurant
            else
                flash[:error] = 'Something went wrong'
                redirect_to @restaurant
            end
        else
            flash[:error] = "No permission!"
        end
    end
    private
    # Use callbacks to share common setup or constraints between actions.
        def set_appointment
        @restaurant = Restaurant.find(params[:id])
        end

        def restaurant_params
            params.require(:restaurant).permit(:name, :description, branches_attributes: [:id, :city, :address, :_destroy])
        end
end
