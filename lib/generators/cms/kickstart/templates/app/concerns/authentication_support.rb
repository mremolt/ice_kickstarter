module AuthenticationSupport
  extend ActiveSupport::Concern

  included do
    helper_method(:current_user)
  end

  def current_user
    cache = session[user_session_key]

    @current_user ||= if cache
      User.new(cache)
    else
      NullUser.new
    end
  end

  private

  def user_session_key
    :user
  end

  def logged_in?
    current_user.logged_in?
  end

  def current_user=(user)
    user ||= NullUser.new

    @current_user = user
    session[user_session_key] = user.cache_attributes
  end

  def discard_user
    session.delete(user_session_key)
  end
end