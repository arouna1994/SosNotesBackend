class PieceJointe < ApplicationRecord
  belongs_to :demande
  has_one_attached :fichier

  after_create :setUuid

  def setUuid
    self.uuid = SecureRandom.uuid
    self.save
  end
end
