class CreatePieceJointes < ActiveRecord::Migration[6.0]
  def change
    create_table :piece_jointes do |t|
      t.references :demande, null: false, foreign_key: true
      t.string :uuid
      t.string :tag

      t.timestamps
    end
  end
end
