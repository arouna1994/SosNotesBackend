class Donnee < ApplicationRecord
    belongs_to :type_document
    has_many :expression,comprehension,stage,emploi
end
