class AddNeuralNetToCryptobot < ActiveRecord::Migration[5.1]
  def change
    add_column :cryptobots, :nn, :decimal
  end
end
