class ChangeUrlToWebsiteForUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :url, :website
  end
end
