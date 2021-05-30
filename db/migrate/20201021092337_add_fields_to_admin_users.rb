class AddFieldsToAdminUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :nom, :string
    add_column :admin_users, :prenom, :string
    add_column :admin_users, :date_naiss, :date
    add_column :admin_users, :pays, :string
    add_column :admin_users, :profil, :string
    add_column :admin_users, :telephone, :string
    add_column :admin_users, :etat, :string
  end
end
