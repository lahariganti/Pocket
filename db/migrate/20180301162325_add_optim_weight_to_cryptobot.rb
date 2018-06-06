class AddOptimWeightToCryptobot < ActiveRecord::Migration[5.1]
  def change
    add_column :cryptobots, :optim_weight, :decimal
  end
end
