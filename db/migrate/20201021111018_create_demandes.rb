class CreateDemandes < ActiveRecord::Migration[6.0]
  def change
    create_table :demandes do |t|
      t.references :type_document, null: false, foreign_key: true
      t.references :admin_user, null: false, foreign_key: true
      t.text :modele
      t.string :etat

      t.timestamps
    end
  end
end
