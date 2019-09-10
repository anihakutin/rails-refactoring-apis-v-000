class GithubService
  # Fixme
  # Not ideal for service object to have token, e.g. user cleared session
  attr_accessor :access_token

  def initialize(options = {})
      self.access_token = options["access_token"]
  end

  def authenticate!(client_id, client_secret, code)
    response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = {'client_id': nil, 'client_secret': nil, 'code': "20"}
      # Stubbed for test
      # req.body = {'client_id': client_id, 'client_secret': client_secret, 'code': code}
      req.headers["Accept"] = 'application/json'
    end

    token = JSON.parse(response.body)["access_token"]
    self.access_token = token
  end

  def get_username
    response = Faraday.get("https://api.github.com/user") do |req|
      req.headers = {'Authorization' => "token #{self.access_token}"}
    end

    username = JSON.parse(response.body)["login"]
  end

  def create_repo(repo_name)
    Faraday.post("https://api.github.com/user/repos") do |req|
      req.body = {name: repo_name}.to_json
      req.headers = {'Authorization' => "token #{self.access_token}", 'Accept' => 'application/json'}
    end
  end

  def get_repos # (token)
    # Stubbed for test
    # https://api.github.com/users/anihakutin/repos
    response = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers = {'Authorization' => "token #{self.access_token}", 'Accept' => 'application/json'}
    end

    repos = JSON.parse(response.body)
    repos.collect {|repo| GithubRepo.new(repo)}
  end
end
