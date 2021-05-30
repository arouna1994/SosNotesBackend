class AddReinitFieldToAdminUser < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :code_reinitialisation, :string
    add_column :admin_users, :date_code, :datetime
    add_column :admin_users, :url_verify_code, :string
    add_column :admin_users, :date_password, :datetime
    add_column :admin_users, :url_password_code, :string
  end
end
