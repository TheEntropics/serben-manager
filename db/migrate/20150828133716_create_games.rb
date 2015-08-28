class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :short_name
      t.text :start_script
      t.text :stop_script
      t.text :status_script
      t.string :icon

      t.timestamps null: false
    end

    add_index :games, :short_name
  end
end
