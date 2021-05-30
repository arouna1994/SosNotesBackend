class CreateServices < ActiveRecord::Migration[6.0]
  def change
    create_table :services do |t|
      t.references :type_document, null: false, foreign_key: true
      t.string :prestation
      t.string :etat

      t.timestamps
    end
  end
end
