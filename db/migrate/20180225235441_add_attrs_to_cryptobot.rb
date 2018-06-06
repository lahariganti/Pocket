class AddAttrsToCryptobot < ActiveRecord::Migration[5.1]
  def change
    add_column :cryptobots, :assetpair, :string
    add_column :cryptobots, :time, :bigint
    add_column :cryptobots, :price, :decimal
  end
end
