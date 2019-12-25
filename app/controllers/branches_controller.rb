class BranchesController < ApplicationController
    before_action :set_branch, only: [:show, :edit, :update, :destroy]
    
      def index
        @restaurants = Restaurant.find(params[:restaurant_id])
        @branches = @restaurants.branches
 
        
      end
    
      def show
        @menu_items = @restaurant.menu_items
        # @order 
        # if request.referer =~ /orders/
        # order = Order.where("branch_id = ? and user_id = ? and total_price = 0", @branch.id, current_user.id)
        # p order
        # order.each {|o| puts o}
        
        @order = Order.where("branch_id = ? and user_id = ?", @branch.id, current_user.id).last
        if !@order
          @order= Order.create(branch_id: @branch.id, user_id: current_user.id, total_price: 0)
        end
          # and Order.last.user_id == current_user.id and Order.last.total_price.nil?
        # end
      end

      def new
          @branch = Branch.new
      end
      
    
      def create
        if can? :create, Branch
            puts branch_params
            @branch = Branch.new(branch_params)
            @branch.restaurant_id = params[:restaurant_id]
            if @branch.save
                # @restaurant << @branch
                flash[:success] = "Branch successfully created"
                redirect_to restaurant_branch_path

            else
                flash[:error] = "Something went wrong"
                redirect_to new_restaurant_branch_path
            end
        else
            flash[:error] = "No permission!"
        end
      end
    
      def update
        if @branch.update(branch_params)
            flash[:success] = "Branch was successfully updated"
            redirect_to restaurant_branch_path
          else
            flash[:error] = "Something went wrong"
            redirect_to edit_restaurant_branch_path
          end
      end
    
      def edit
        if !can? :edit, @branch
            flash[:error] = "Something went wrong"
            redirect_to restaurant_branch_path
        end
      end
    
      def destroy
        if current_user.admin?
            if @branch.destroy
                flash[:success] = 'Branch was successfully deleted.'
                redirect_to restaurant_branch_path
            else
                flash[:error] = 'Something went wrong'
                redirect_to restaurant_branch_path
            end
        else
            flash[:error] = "No permission!"
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
          def set_branch
            puts params[:restaurant_id]
            @restaurant = Restaurant.find(params[:restaurant_id])
            @branch = @restaurant.branches.find(params[:id])
            # @branch = Branch.find(params[:id])
          end
  
          def branch_params
              params.require(:branch).permit(:city, :address)
          end
end
