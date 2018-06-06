class AddAttrsToPortfolio < ActiveRecord::Migration[5.1]
  def change
    add_column :portfolios, :assetpair, :string
    add_column :portfolios, :poket, :decimal
    add_column :portfolios, :poket_value, :decimal
  end
end
