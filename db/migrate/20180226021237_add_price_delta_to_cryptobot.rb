class AddPriceDeltaToCryptobot < ActiveRecord::Migration[5.1]
  def change
    add_column :cryptobots, :pricedelta, :decimal
  end
end
