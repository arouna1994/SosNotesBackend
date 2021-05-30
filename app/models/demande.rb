class Demande < ApplicationRecord
  belongs_to :type_document
  belongs_to :admin_user

  serialize :data, JSON
end
