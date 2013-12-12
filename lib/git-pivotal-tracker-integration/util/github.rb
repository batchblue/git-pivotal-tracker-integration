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

require 'git-pivotal-tracker-integration/util/git'
require 'octokit'

class GitPivotalTrackerIntegration::Util::Github

  # Creates a pull request from the current branch to the parent branch
  #
  def self.create_pull_request(github_client, repo_url, title, body)
    repo = Octokit::Repository.from_url repo_url
    github_client.create_pull_request \
      repo,
      GitPivotalTrackerIntegration::Util::Git.branch_name,
      title,
      body
  end

end
