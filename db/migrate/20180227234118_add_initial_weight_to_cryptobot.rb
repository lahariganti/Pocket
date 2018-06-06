class AddInitialWeightToCryptobot < ActiveRecord::Migration[5.1]
  def change
    add_column :cryptobots, :initial_weight, :decimal
  end
end
