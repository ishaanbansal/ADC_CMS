class AlterUsers < ActiveRecord::Migration
  def up
    add_column("users", "phone", :integer, :limit => 15, :after => "email")
    add_column("users", "address", :string, :limit => 150, :after => "phone")
  end

  def down
    remove_column("users", "phone")
    remove_column("users", "address")
  end

end
