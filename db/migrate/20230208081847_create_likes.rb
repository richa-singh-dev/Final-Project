class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|

      t.belongs_to :user, index: true
      t.belongs_to :article, index: true

      # a user can like an article only once
      t.index [:user_id, :article_id],  unique: true
      t.timestamps
    end
  end
end
