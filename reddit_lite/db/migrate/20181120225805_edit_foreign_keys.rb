class EditForeignKeys < ActiveRecord::Migration[5.2]
  def change
    rename_column(:posts, :author, :author_id)
    rename_column(:subs, :moderator, :moderator_id)
  end
end
