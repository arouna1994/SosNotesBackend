class RemoveModeleFromDemandes < ActiveRecord::Migration[6.0]
  def change
    remove_column :demandes, :modele, :string
  end
end
