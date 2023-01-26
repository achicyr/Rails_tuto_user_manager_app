class AddRecoverPasswordToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :recover_password, :string
  end
end
