class AddStatusToDemandes < ActiveRecord::Migration[6.0]
  def change
    add_column :demandes, :status, :boolean
  end
end
