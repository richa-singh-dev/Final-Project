class AddColumnsToArticle < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :article_likes_count, :integer, :default => 0
    add_column :articles, :article_comments_count, :integer, :default => 0
  end
end
