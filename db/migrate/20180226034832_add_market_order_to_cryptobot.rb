class AddMarketOrderToCryptobot < ActiveRecord::Migration[5.1]
  def change
    add_column :cryptobots, :order, :string
  end
end
