class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|

      t.text :comment_text
      t.belongs_to :user, index: true
      t.belongs_to :article, index: true

      t.timestamps
    end
  end
end
