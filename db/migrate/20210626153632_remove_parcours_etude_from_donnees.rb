class RemoveParcoursEtudeFromDonnees < ActiveRecord::Migration[6.0]
  def change
    remove_column :donnees, :parcours_etude, :text
  end
end
