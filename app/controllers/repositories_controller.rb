class RepositoriesController < ApplicationController
  # skip_before_action :authenticate_user

  def index
    github_service = GithubService.new({"access_token" => "#{session[:token]}"})

    @repos_array = github_service.get_repos
  end

  def create
    github_service = GithubService.new({"access_token" => "#{session[:token]}"})
    github_service.create_repo(params[:name])

    redirect_to '/'
  end
end
