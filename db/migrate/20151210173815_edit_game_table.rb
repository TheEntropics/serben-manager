class EditGameTable < ActiveRecord::Migration
  def change
    remove_column :games, :start_script
    remove_column :games, :stop_script
    remove_column :games, :status_script

    add_column :games, :service_name, :string

    Game.update_all('service_name = short_name')
  end
end
