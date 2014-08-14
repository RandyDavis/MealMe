class CreatePlan < ActiveRecord::Migration
  def self.up
    create_table :plans do |p|
      p.references   :users
      # p.references   :meals
      p.string       :expired
      # has_many     :meals
      # belongs_to   :users
      p.timestamps

    end
  end

  def self.down
    drop_table :plans
  end
end
