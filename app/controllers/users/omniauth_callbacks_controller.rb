# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def line
    debug_log("[d] OmniauthCallbacks_Ctrl: ac: line")  # log
    callback_from(:line)
  end

  def facebook
    debug_log("[d] OmniauthCallbacks_Ctrl: ac: facebook")  # log
    callback_from(:facebook)
  end

  def google_oauth2
    debug_log("[d] OmniauthCallbacks_Ctrl: ac: google_oauth2")  # log
    callback_from(:google_oauth2)
  end

  private
  def callback_from(provider)
    debug_log("[d] OmniauthCallbacks_Ctrl: ac: callback_from ： provider = #{provider}")  # log

    provider = provider.to_s

    @user = User.find_for_oauth(request.env['omniauth.auth'])

    debug_log("@user = #{@user.inspect}")  # log

    if @user.persisted?
      debug_log("[d] OmniauthCallbacks_Ctrl: ac: callback_from：if ok (@user.persisted?)")  # log
      flash[:success] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      
      # @userがアクティブ化されていない場合スローされる
      sign_in_and_redirect @user, event: :authentication
    else
      debug_log("[d] OmniauthCallbacks_Ctrl: ac: callback_from：if ng (@user.persisted?)")  # log
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      
      redirect_to new_user_registration_url
    end
  end
end
