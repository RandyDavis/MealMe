class PlanMeal < ActiveRecord::Migration
  def self.up
    create_table :plan_meals do |pm|
      # pm.references   :users
      pm.references   :meals
      pm.references   :plans
    end
  end

  def self.down
    drop_table :meals
  end
end
