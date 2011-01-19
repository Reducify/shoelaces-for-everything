class CreateSomethings < ActiveRecord::Migration
  def self.up
    create_table :somethings do |t|
      t.string :name
      t.string :email
      t.string :title
      t.text :description
      t.string :ip_address
      t.string :something
      t.timestamps
    end
  end

  def self.down
    drop_table :somethings
  end
end
