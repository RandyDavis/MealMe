class CreateMeal < ActiveRecord::Migration
  def self.up
    create_table :meals do |m|
      m.string     :name
      m.string     :category
      m.string     :homemade1
      m.string     :homemade2
      m.string     :homemade3
      m.string     :homemade4
      m.string     :homemade5
      m.string     :restaurant1
      m.string     :restaurant2
      m.string     :restaurant3
      m.string     :restaurant4
      m.string     :restaurant5
      # m.references :users
      # belongs_to   :users
      m.timestamps
    end
  end

  def self.down
    drop_table :meals
  end
end
