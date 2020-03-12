class RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    if params[:user][:type] == 'Developer'
      new_developer_path
    else
      new_company_path
    end
  end

end
