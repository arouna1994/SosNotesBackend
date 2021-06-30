class AddDonneIdToEmplois < ActiveRecord::Migration[6.0]
  def change
    add_column :emplois, :donnee_id, :bigint
  end
end
