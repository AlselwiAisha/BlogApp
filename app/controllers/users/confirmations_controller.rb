class Users::ConfirmationsController < Devise::ConfirmationsController
  def create
    self.resource = resource_class.find_by(email: params[:user][:email])

    if resource && !resource.confirmed?
      resource.confirm
      sign_in(resource)
      set_flash_message(:notice, :confirmed) if is_flashing_format?
      respond_with_navigational(resource) { redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      set_flash_message(:alert, :already_confirmed) if is_flashing_format?
      redirect_to new_user_confirmation_path
    end
  end
end
