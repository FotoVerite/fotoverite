module SessionMethods

  protected

    # Member sessions

    def logged_in?
      unless current_user
        return false
      else
        return true
      end
    end

    def current_user
      unless @current_user == false
        @current_user ||= (login_from_session || login_from_cookie)
        @current_member ||= @current_user
        return @current_user
      end
    end

    def current_user=(new_user)
      session[:id] = new_user ? new_user.id : nil
      # :wid is stored just to make DON debugging easier
      session[:wid] = new_user ? new_user.webuser_id : nil
      session[:student] = new_user ? new_user.student? : nil
      new_user.refresh_samples_bought if new_user
      @current_user = new_user || false
    end

    def login_from_session
      user = MemberLogin.find_by_id(session[:id]) if session[:id]
      if user
        if user.enabled?
          self.current_user = user
          return current_user
        else
          # they may have been disabled mid-session
          logout_keeping_session!
        end
      end
    end

    def login_from_cookie
      user = MemberLogin.find_by_remember_token(cookies[:auth_token]) if cookies[:auth_token]
      if user && user.remember_token?
        if user.enabled?
          self.current_user = user
          handle_remember_cookie!(user, false) # freshen cookie token (keeping date)
          return current_user
        else
          # they may have been disabled mid-session
          logout_keeping_session!
        end
      end
    rescue
      logout_killing_session!
    end

    # The session should only be reset at the tail end of a form POST --
    # otherwise the request forgery protection fails. It's only really necessary
    # when you cross quarantine (logged-out to logged-in).
    def logout_killing_session!
      logout_keeping_session!
      reset_session
    end

    def logout_keeping_session!
      @current_user = false
      kill_remember_cookie!     # Kill client-side auth cookie
      session[:id] = nil
      session[:student] = nil
      session[:samples_today] = nil
      session[:samples_updated_at] = nil
      session[:last_search] = nil
      session[:unplaced_order] = nil
      # explicitly kill any other session variables you set
    end


    # Admin Sessions

    def admin_logged_in?
      unless current_admin
        return false
      else
        return true
      end
    end

    def current_admin
      unless @current_admin == false
        @current_admin ||= (login_admin_from_session || login_admin_from_cookie)
      end
    end

    def current_admin=(admin)
      session[:admin_id] = admin ? admin.id : nil
      @current_admin = admin || false
    end

    def login_admin_from_session
      return unless session[:admin_id]
      admin = Admin.find_by_id(session[:admin_id])
      if admin
        if admin.enabled?
          self.current_admin = admin
          return current_admin
        else
          # they may have been disabled mid-session
          logout_admin_keeping_session!
        end
      end
    end

    def login_admin_from_cookie
      admin = Admin.find_by_remember_token(cookies[:auth_token]) if cookies[:auth_token]
      if admin && admin.remember_token?
        if admin.enabled?
          self.current_admin = admin
          handle_remember_cookie!(admin, false) # freshen cookie token (keeping date)
          return current_admin
        else
          # they may have been disabled mid-session
          logout_admin_keeping_session!
        end
      end
    end

    def logout_admin_killing_session!
      logout_admin_keeping_session!
      reset_session
    end

    def logout_admin_keeping_session!
      @current_admin.forget_me if @current_admin  # Kill server-side auth cookie
      @current_admin = false
      kill_remember_cookie!     # Kill client-side auth cookie
      session[:admin_id] = nil
    end


    # Remember cookie methods

    def kill_remember_cookie!
      cookies.delete :auth_token
    end

    def valid_remember_cookie?(user)
      return nil unless user
      (user.remember_token?) && (cookies[:auth_token] == user.remember_token)
    end

    def send_remember_cookie!(user)
      cookies[:auth_token] = {
        :value => user.remember_token,
        :expires => user.remember_token_expires_at
      }
    end

    # Refresh the cookie auth token if it exists, create it otherwise
    def handle_remember_cookie!(user, new_cookie_flag)
      return unless user
      case
      when valid_remember_cookie?(user) then user.refresh_token # keeping same expiry date
      when new_cookie_flag              then user.remember_me
      else                                   user.forget_me
      end
      send_remember_cookie!(user)
    end


end
