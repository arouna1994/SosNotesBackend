class RemoveEmploiFromDonnees < ActiveRecord::Migration[6.0]
  def change
    remove_column :donnees, :emploi, :text
  end
end
