class CustomersController < ApplicationController
  before_action :authenticate_admin!

  def edit_customer
    # Renders the form
  end

  def manage_customer
    if current_admin.update(update_customer_params)
      flash[:notice] = "Profile updated successfully."
      redirect_to root_path
    else
      flash[:alert] = current_admin.errors.full_messages.join(", ")
      redirect_to edit_customer_path
    end
  end

  private

  def update_customer_params
    params.require(:customer).permit(:username, :first_name, :last_name, :email)
  end
end
