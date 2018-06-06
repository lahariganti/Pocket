class AddAmountToCryptobots < ActiveRecord::Migration[5.1]
  def change
    add_column :cryptobots, :amount, :decimal
  end
end
