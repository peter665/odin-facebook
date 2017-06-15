class AddCommentableToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :commentable_id,   :integer
    add_column :comments, :commentable_type, :string
    remove_column :comments, :post_id

    add_index :comments, [:commentable_id, :commentable_type]
  end
end
