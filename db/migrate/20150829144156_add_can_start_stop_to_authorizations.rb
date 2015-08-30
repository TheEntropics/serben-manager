class AddCanStartStopToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :can_start, :boolean
    add_column :authorizations, :can_stop, :boolean
  end
end
