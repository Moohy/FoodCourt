class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :edit, :update, :destroy]

    def index
        if can? :manage, Order
            @orders = Order.all
        else 
            redirect_to root_path, alert: "No order belong to you!"
        end
        
        
        
        
    end

    def orders 
        @orders = Order.where(user_id: current_user.id)
        redirect_to(root_path, alert: "No order belong to you!") if @orders.nil?
    end

    def show
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
            
            
            @order = Order.new({branch_id: params[:branch_id],  :user_id => current_user.id, total_price: 0})
            
            
            if @order.save
                
                redirect_to restaurant_branch_path(params[:restaurant_id], params[:branch_id]), notice: "Order successfully created"
            else
                
                redirect_to new_restaurant_branch_order_path, alert: "Something went wrong"
            end
        else
            flash[:error] = "No permission!"
        end
    end

    def edit
        if !can? :update, @order
            
            redirect_to restaurant_branch_path(params[:branch_id]), alert: "Something went wrong"
        end
    end
    

    def update
        if @order.update(order_params)
        
          redirect_to restaurant_branch_path(params[:branch_id]), notice: "Order was successfully updated"
        else
        
          redirect_to edit_restaurant_branch_order_path, alert: "Something went wrong"
        end
    end
    

    def destroy
        if current_user.admin?
            if @order.destroy
                
                redirect_to restaurant_branch_path(params[:branch_id]), notice: 'Order was successfully deleted.'
            else
                
                redirect_to restaurant_branch_path(params[:branch_id]), alert: "Something went wrong"
            end
        else
            flash[:error] = "No permission!"
        end
    end
    private
    
        def set_order
            @restaurant = Restaurant.find(params[:restaurant_id])
            @branch = Branch.find(params[:branch_id])
            @order = Order.find(params[:id])
        end

        def order_params
            params.require(:order).permit(:branch_id)
        end
end
