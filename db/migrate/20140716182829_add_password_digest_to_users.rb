class AddPasswordDigestToUsers < ActiveRecord::Migration

  def up
    remove_column "users", "hashed_password"
    add_column "users", "password_digest", :string
  end

  def down
    add_column "users", "hashed_password", :string, :limit => 40
    remove_column "users", "password_digest"
  end

end
