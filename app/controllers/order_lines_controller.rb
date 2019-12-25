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
          # h = {price: price}
          param = order_line_params.merge price
          @order_line = OrderLine.new(param)
          # @order_line.restaurant_id = params[:restaurant_id]
          respond_to do |format|
              
          
            if @order_line.save
              # @order_line.updatePrice(price[:price])
                format.js
                # flash[:success] = "OrderLine successfully created"
                format.html {redirect_to restaurant_branch_path params[:restaurant_id], params[:branch_id]}

            else
                # flash[:error] = "Something went wrong"
                # format.html {redirect_to new_restaurant_branch_order_order_line_path}
                formaj.js
            end
          end
      else
          flash[:error] = "No permission!"
      end
    end
  
    def update
      if @order_line.update(order_line_params)
          flash[:success] = "OrderLine was successfully updated"
          redirect_to restaurant_branch_order_order_line_path
        else
          flash[:error] = "Something went wrong"
          redirect_to edit_restaurant_branch_order_order_line_path
        end
    end
  
    def edit
      if !can? :edit, @order_line
          flash[:error] = "Something went wrong"
          redirect_to restaurant_branch_order_order_line_path
      end
    end
  
    def destroy
      if current_user.admin?
          if @order_line.destroy
              flash[:success] = 'OrderLine was successfully deleted.'
              @order.updateTotal()
              redirect_to restaurant_branch_order_order_line_path
          else
              flash[:error] = 'Something went wrong'
              redirect_to restaurant_branch_order_order_line_path
          end
      else
          flash[:error] = "No permission!"
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
        def set_order_line
          puts params[:order_id]
          @restaurant = Restaurant.find(params[:restaurant_id])
          @branch = Branch.find(params[:branch_id])
          @order = Order.find(params[:order_id])
          @order_line = @order.order_linees.find(params[:id])
        end

        def order_line_params
            params.require(:order_line).permit(:menu_item_id, :order_id, :quantity)
        end
end
