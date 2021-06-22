class CreateDonnees < ActiveRecord::Migration[6.0]
  def change
    create_table :donnees do |t|
      t.references :type_document, null: false, foreign_key: true
      t.string :structure_ciblee
      t.string :nom
      t.string :prenom
      t.string :date_naissance
      t.string :etat_civil
      t.string :adresse_phy
      t.string :email
      t.string :telephone
      t.string :parcours_etude
      t.text :stage
      t.text :emploi

      t.timestamps
    end
  end
end
