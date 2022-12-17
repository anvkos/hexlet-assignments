# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  # BEGIN
  test 'should create' do
    repo_name = 'octokit/octokit.rb'
    api_repo_url = "https://api.github.com/repos/#{repo_name}"
    repo_url = "https://github.com/#{repo_name}"

    stub_request(:get, api_repo_url)
      .to_return(body: load_fixture('files/response.json'), headers: { 'Content-Type' => 'json' })

    assert_difference -> { Repository.count }, 1 do
      post repositories_path, params: { repository: { link: repo_url } }
    end
  end
  # END
end
