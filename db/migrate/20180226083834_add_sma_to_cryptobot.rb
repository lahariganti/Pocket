class AddSmaToCryptobot < ActiveRecord::Migration[5.1]
  def change
    add_column :cryptobots, :sma, :decimal
  end
end
