class OrdersController < ApplicationController
    before_action :set_appointment, only: [:show, :edit, :update, :destroy]

    def index
        @orders = Order.all
        # @menu_items = MenuItem.all
        # cities_arr = []
        # @orders.each {|r| puts r.branches.each { |b| puts cities_arr << b.city}}
        # @branches_by_cities = cities_arr.uniq!
    end

    def show
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
                flash[:success] = "Order successfully created"
                redirect_to restaurant_branch_path(params[:restaurant_id], params[:branch_id])
            else
                flash[:error] = "Something went wrong"
                redirect_to new_restaurant_branch_order_path
            end
        else
            flash[:error] = "No permission!"
        end
    end

    def edit
        if !can? :update, @order
            flash[:error] = "Something went wrong"
            redirect_to restaurant_branch_path(params[:branch_id])
        end
    end
    

    def update
        if @order.update(order_params)
          flash[:success] = "Order was successfully updated"
          redirect_to restaurant_branch_path(params[:branch_id])
        else
          flash[:error] = "Something went wrong"
          redirect_to edit_restaurant_branch_order_path
        end
    end
    

    def destroy
        if current_user.admin?
            if @order.destroy
                flash[:success] = 'Order was successfully deleted.'
                redirect_to restaurant_branch_path(params[:branch_id])
            else
                flash[:error] = 'Something went wrong'
                redirect_to restaurant_branch_path(params[:branch_id])
            end
        else
            flash[:error] = "No permission!"
        end
    end
    private
    # Use callbacks to share common setup or constraints between actions.
        def set_appointment
            @order = Order.find(params[:id])
        end

        def order_params
            params.require(:order).permit(:branch_id)
        end
end
