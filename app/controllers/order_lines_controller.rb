class OrderLinesController < ApplicationController
    before_action :set_order_line, only: [:show, :edit, :update, :destroy]
    respond_to :js, :html

    def new
        @restaurant = Restaurant.find(params[:restaurant_id])
        @branch = Branch.find(params[:branch_id])
        @order = Order.find(params[:order_id])
        @order_line = OrderLine.new
    end

    def items_for_order
        @order_lines = OrderLines.order.where('id = ?', params[:order_id])
    end
    
  
    def create
      if can? :create, OrderLine
          price = {price: (order_line_params[:quantity].to_f * MenuItem.find(order_line_params[:menu_item_id]).price).to_f.as_json}
          
          param = order_line_params.merge price
          @order_line = OrderLine.new(param)
          
          respond_to do |format|
              
          
            if @order_line.save
              
                format.js
                
                format.html {redirect_to restaurant_branch_path params[:restaurant_id], params[:branch_id], notice: "OrderLine was successfully created"}

            else
                
                
                formaj.js
            end
          end
      else
          flash[:error] = "No permission!"
      end
    end
  
    def update
      if @order_line.update(order_line_params)
          
          redirect_to restaurant_branch_order_order_line_path, notice: "OrderLine was successfully updated"
        else
          
          redirect_to edit_restaurant_branch_order_order_line_path, alert: "Something went wrong"
        end
    end
  
    def edit
      if !can? :edit, @order_line
          
          redirect_to restaurant_branch_order_order_line_path, alert: "Something went wrong"
      end
    end
  
    def destroy
      if current_user.admin? or current_user.id == @order_line.order.user_id
          if @order_line.destroy
              
              redirect_to restaurant_branch_path(@restaurant, @branch), notice: 'OrderLine was successfully deleted.'
          else
              
              redirect_to restaurant_branch_path(@restaurant, @branch), alert: "Something went wrong"
          end
      else
          flash[:error] = "No permission!"
      end
    end

    private
    
        def set_order_line
          puts params[:order_id]
          @restaurant = Restaurant.find(params[:restaurant_id])
          @branch = Branch.find(params[:branch_id])
          @order = Order.find(params[:order_id])
          @order_line = @order.order_lines.find(params[:id])
        end

        def order_line_params
            params.require(:order_line).permit(:menu_item_id, :order_id, :quantity)
        end
end
