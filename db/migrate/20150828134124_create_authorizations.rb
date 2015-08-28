class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.integer :user_id
      t.integer :game_id

      t.timestamps null: false
    end
    add_index :authorizations, :user_id
    add_index :authorizations, :game_id
  end
end
