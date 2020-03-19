class AddGithubStatsToDeveloper < ActiveRecord::Migration[5.2]
  def change
    add_column :developers, :welcome_message, :boolean, default: true
    add_column :developers, :github_public_repos, :integer
    add_column :developers, :github_avatar_url, :string
    add_column :developers, :github_username, :string
    add_column :developers, :github_followers, :integer
  end
end
