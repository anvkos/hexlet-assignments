# frozen_string_literal: true

require 'uri'

class FetchRepositoryInfoService
  def call(id)
    repository = Repository.find(id)
    repository.fetch!
    repo_data = fetch_repo_info(repository.link).to_h
    repository.fetch_finished!
    repository.update!(
      owner_name: repo_data[:owner][:login],
      repo_name: repo_data[:name],
      description: repo_data[:description],
      default_branch: repo_data[:default_branch],
      watchers_count: repo_data[:watchers_count],
      language: repo_data[:language],
      repo_created_at: repo_data[:created_at],
      repo_updated_at: repo_data[:updated_at]
    )
  rescue Octokit::InvalidRepository, Octokit::NotFound => error
    repository.fetch_failed!
  end

  private

  def fetch_repo_info(link)
    uri = URI.parse(link)
    repo_name = uri.path.delete_prefix('/')
    client = Octokit::Client.new
    client.repo(repo_name)
  end
end
