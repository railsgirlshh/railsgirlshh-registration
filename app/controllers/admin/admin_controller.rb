module Admin
  class AdminController < ApplicationController
    layout "admin"

    skip_before_action :authenticate

    before_action :authenticate_admin unless Rails.env.test?

    protected

    def authenticate_admin
      valid = authenticate_or_request_with_http_basic("Rails Girls Hamburg Registration Admin") do |username,password|
        ::AdminAccount.exists?(username: username, password_sha1: Digest::SHA1.hexdigest(password))
      end
      request_http_basic_authentication unless valid
    end
  end
end
