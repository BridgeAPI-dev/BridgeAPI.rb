class AddNotNullToEmailAndPassword < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:users, :password_hash, false)
    change_column_null(:users, :email, false)
  end
end
