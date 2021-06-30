class RemoveStageFromDonnees < ActiveRecord::Migration[6.0]
  def change
    remove_column :donnees, :stage, :text
  end
end
