class ChangeUserIdInCommentsToInt < ActiveRecord::Migration
  def change
    remove_column :comments, :user_id, :string
    add_column :comments, :user_id, :integer
  end
end
