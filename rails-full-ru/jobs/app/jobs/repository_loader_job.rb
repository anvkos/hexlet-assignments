# frozen_string_literal: true

class RepositoryLoaderJob < ApplicationJob
  queue_as :default

  def perform(repository_id)
    FetchRepositoryInfoService.new.call(repository_id)
  end
end