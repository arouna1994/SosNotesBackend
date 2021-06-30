class AddLangueToExpressions < ActiveRecord::Migration[6.0]
  def change
    add_column :expressions, :langue, :string
  end
end
