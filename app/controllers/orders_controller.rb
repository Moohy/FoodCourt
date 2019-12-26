class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :edit, :update, :destroy]

    def index
        @orders = Order.all
        # @menu_items = MenuItem.all
        # cities_arr = []
        # @orders.each {|r| puts r.branches.each { |b| puts cities_arr << b.city}}
        # @branches_by_cities = cities_arr.uniq!
    end

    def show
        # if current_user.admin?
        #     @order = Order.find(params[:id])
        # elsif current_user.vendor?
        #    if Branch.find(Order.find(params[:id]).branch_id).restaurant.user_id == current_user.id
        #         @order = Order.find(params[:id])
        #    end
        # elsif current_user.customer?
        #     @order = Order.where(user_id: current_user.id)
        # else
        #     redirect_to root_path, alert: "No order belong to you!"
        # end
        if can? :read, Order
            @order = Order.find(params[:id])
        else
            redirect_to root_path, alert: "No order belong to you!"
        end
    end

    def new
        if can? :create, Order
            create
        else
            flash[:error] = "No permission!"
        end
    end

    def create
        if can? :create, Order
            # puts order_params
            # order_params += "total_price" => 0 << "user_id" => current_user.id
            @order = Order.new({branch_id: params[:branch_id],  :user_id => current_user.id, total_price: 0})
            # @order.user_id = current_user.id
            
            if @order.save
                # flash[:success] = 
                redirect_to restaurant_branch_path(params[:restaurant_id], params[:branch_id]), notice: "Order successfully created"
            else
                # flash[:error] = "Something went wrong"
                redirect_to new_restaurant_branch_order_path, alert: "Something went wrong"
            end
        else
            flash[:error] = "No permission!"
        end
    end

    def edit
        if !can? :update, @order
            # flash[:error] = "Something went wrong"
            redirect_to restaurant_branch_path(params[:branch_id]), alert: "Something went wrong"
        end
    end
    

    def update
        if @order.update(order_params)
        #   flash[:success] = 
          redirect_to restaurant_branch_path(params[:branch_id]), notice: "Order was successfully updated"
        else
        #   flash[:error] = "Something went wrong"
          redirect_to edit_restaurant_branch_order_path, alert: "Something went wrong"
        end
    end
    

    def destroy
        if current_user.admin?
            if @order.destroy
                # flash[:success] = 
                redirect_to restaurant_branch_path(params[:branch_id]), notice: 'Order was successfully deleted.'
            else
                # flash[:error] = 'Something went wrong'
                redirect_to restaurant_branch_path(params[:branch_id]), alert: "Something went wrong"
            end
        else
            flash[:error] = "No permission!"
        end
    end
    private
    # Use callbacks to share common setup or constraints between actions.
        def set_order
            @restaurant = Restaurant.find(params[:restaurant_id])
            @branch = Branch.find(params[:branch_id])
            @order = Order.find(params[:id])
        end

        def order_params
            params.require(:order).permit(:branch_id)
        end
end
