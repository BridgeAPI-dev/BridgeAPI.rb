class AddDataToBridges < ActiveRecord::Migration[6.0]
  def change
    add_column :bridges, :data, :jsonb, null: false
  end
end
