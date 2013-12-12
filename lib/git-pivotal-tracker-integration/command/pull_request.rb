# Git Pivotal Tracker Integration
# Copyright (c) 2013 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'git-pivotal-tracker-integration/command/base'
require 'git-pivotal-tracker-integration/command/command'
require 'git-pivotal-tracker-integration/util/git'
require 'git-pivotal-tracker-integration/util/github'
require 'octokit'

# The class that encapsulates starting a Pivotal Tracker Story
class GitPivotalTrackerIntegration::Command::PullRequest < GitPivotalTrackerIntegration::Command::Base

  def initialize
    super
    @github_client = Octokit::Client.new \
      :login => @configuration.github_login,
      :password => @configuration.github_password
  end

  def run(argument)
    no_complete = argument =~ /--no-complete/
    GitPivotalTrackerIntegration::Util::Github.create_pull_request \
      @github_client,
      @configuration.github_repo_url,
      pull_request_title(@configuration.story(@project), no_complete),
      pull_request_body
  end

  private
  def pull_request_title(story, no_complete)
    prefix = "[#{no_complete ? '' : 'Completes '}##{story.id}]"
    title =  prefix + ask("Enter pull request title (#{prefix} <title>): ")
    puts
    title
  end

  def pull_request_body
    body = ask("Enter pull request body: ")
    puts
    body
  end

  KEY_ROOT_BRANCH = 'root-branch'.freeze
end
