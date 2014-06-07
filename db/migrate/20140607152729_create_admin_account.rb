class CreateAdminAccount < ActiveRecord::Migration
  def change
    create_table :admin_accounts do |t|
      t.string :username
      t.string :password_sha1

      t.timestamps
    end
  end
end
