class RegistrationsController < Devise::RegistrationsController
  protected
  def build_resource(hash=nil)
    hash ||= params[resource_name] || {}
    self.resource = resource_class.new_with_session(hash, session)
  end

  private
  def sign_up_params
    params.require(:user).permit(:email, :username, :first_name, :last_name, :password,
    :password_confirmation)
  end
  def account_update_params
    params.require(:user).permit(:email, :username, :first_name, :last_name, :password,
    :password_confirmation, :current_password)
  end
end
