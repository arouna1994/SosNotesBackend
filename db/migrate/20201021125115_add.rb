class Add < ActiveRecord::Migration[6.0]
  def change
    add_attachment :piece_jointes, :fichier
  end
end
