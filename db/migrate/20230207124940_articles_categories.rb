class ArticlesCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :articles_categories, id: false do |t|
      t.belongs_to :article
      t.belongs_to :category
      t.index [:article_id, :category_id],  unique: true
    end
  end
end
