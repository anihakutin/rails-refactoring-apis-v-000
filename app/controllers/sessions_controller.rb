class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    github_service = GithubService.new # (access_token: session[:token])
    session[:token] = github_service.authenticate!(
                      ENV["CLIENT_ID"],
                      ENV["CLIENT_SECRET"],
                      params[:code])
    session[:username] = github_service.get_username

    redirect_to '/'
  end
end
