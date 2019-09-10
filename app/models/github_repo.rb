class GithubRepo
  attr_accessor :name, :url

  def initialize(options)
    self.name = options["name"]
    self.url = options["html_url"]
  end
end
