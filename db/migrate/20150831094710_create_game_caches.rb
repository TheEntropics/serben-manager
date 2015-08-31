class CreateGameCaches < ActiveRecord::Migration
  def change
    create_table :game_caches do |t|
      t.integer :game_id
      t.text :status
      t.boolean :invalidated
      t.datetime :created_at
    end

    add_index :game_caches, :game_id
    add_index :game_caches, :created_at
  end
end
