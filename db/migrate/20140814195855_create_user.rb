class CreateUser < ActiveRecord::Migration
  def self.up
    create_table :users do |u|
      u.string     :username
      u.string     :password
      u.references :plans
      # has_many     :meals
      has_many     :plans, :through => :meals
      u.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
