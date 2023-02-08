class AddImageUrlToUserAndArticle < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :avatar_url, :string
    add_column :articles, :image_url, :string
  end
end
