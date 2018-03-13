class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users, id: false do |t|
  		t.string :email
  		t.string :name
  	end
  	execute "ALTER TABLE users ADD PRIMARY KEY (email);"
  end
end