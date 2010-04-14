class ActsAsFannableMigration < ActiveRecord::Migration
  def self.up
    create_table "fans", :force => true do |t|
      t.column "fannable_id", :integer, :default => 0, :null => false
      t.column "fannable_type", :string, :default => "", :null => false
      t.column "user_id", :integer, :default => 0, :null => false
      t.timestamps
    end
  
    add_index "fans", ["user_id"], :name => "fk_fans_user"
  end

  def self.down
    drop_table :fans
  end
end
