# All engines will inherit from this controller (naming convention)
class ApplicationController < ActionController::Base

  layout Kaui.config[:layout]

  protect_from_forgery

  before_filter :authenticate_user!, :check_for_redirect_to_tenant_screen

  def check_for_redirect_to_tenant_screen
    unless Kaui.is_user_assigned_valid_tenant?(current_user, session)
      flash[:error] = 'No tenants configured for users AND KillBillClient.api_key, KillBillClient.api_secret have not been set'
      session[:kb_tenant_id] = nil
      redirect_to Kaui.tenant_home_path.call
    end
  end

end
