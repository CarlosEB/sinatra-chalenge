class CreateUserStatistics < ActiveRecord::Migration
  def up
    create_table :user_statistics do |t|
  		t.string :email
      t.string :url
  		t.datetime :access_date
  	end
  	execute "CREATE INDEX ON user_statistics (email);"
  	execute "ALTER TABLE user_statistics ALTER COLUMN access_date SET DEFAULT now();";
  end
end