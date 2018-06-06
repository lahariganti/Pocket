class AddEmaToCryptobot < ActiveRecord::Migration[5.1]
  def change
    add_column :cryptobots, :ema, :decimal
  end
end
