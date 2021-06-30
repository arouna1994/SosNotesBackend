class CreateCompetences < ActiveRecord::Migration[6.0]
  def change
    create_table :competences do |t|
      t.references :donnee, null: false, foreign_key: true
      t.string :annee
      t.text :contenu

      t.timestamps
    end
  end
end
