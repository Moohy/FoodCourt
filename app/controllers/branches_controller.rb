class BranchesController < ApplicationController
    before_action :set_branch, only: [:show, :edit, :update, :destroy]
    
      def index
        @restaurants = Restaurant.find(params[:restaurant_id])
        @branches = @restaurants.branches
 
        
      end
    
      def show
        if (!current_user)
          redirect_to(root_path, alert: "Login to Order or view")
        else
          @menu_items = @restaurant.menu_items
          @order = Order.where("branch_id = ? and user_id = ?", @branch.id, current_user.id).last
          if !@order
            @order= Order.create(branch_id: @branch.id, user_id: current_user.id, total_price: 0)
          end
        end

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

                redirect_to restaurant_branch_path, notice: "Branch successfully created"

            else
                
                redirect_to new_restaurant_branch_path, alert: "Something went wrong"
            end
        else
          redirect_to edit_restaurant_branch_path, alert: "Something went wrong"
        end
      end
    
      def update
        if @branch.update(branch_params)
            
            redirect_to restaurant_branch_path, notice: "Branch was successfully updated"
          else
            
            redirect_to edit_restaurant_branch_path, alert: "Something went wrong"
          end
      end
    
      def edit
        if !can? :edit, @branch
            
            redirect_to restaurant_branch_path, alert: "Something went wrong"
        end
      end
    
      def destroy
        if current_user.admin?
            if @branch.destroy
                
                redirect_to restaurant_branch_path, notice: 'Branch was successfully deleted.'
            else
                
                redirect_to restaurant_branch_path, alert: "Something went wrong"
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
            
          end
  
          def branch_params
              params.require(:branch).permit(:city, :address)
          end
end
