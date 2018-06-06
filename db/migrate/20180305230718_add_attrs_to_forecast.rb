class AddAttrsToForecast < ActiveRecord::Migration[5.1]
  def change
    add_column :forecasts, :assetpair, :string
    add_column :forecasts, :time, :bigint
    add_column :forecasts, :tbats, :decimal
  end
end
