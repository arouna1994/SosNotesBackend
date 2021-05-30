class AddAttachmentToPieceJointe < ActiveRecord::Migration[6.0]
  def change
    remove_attachment :piece_jointes, :fichier
    add_attachment :piece_jointes, :fich
  end
end
