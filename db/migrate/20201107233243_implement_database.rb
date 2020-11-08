class ImplementDatabase < ActiveRecord::Migration[6.0]
  def change
    create_table :bridges do |t|
      t.string :name, null: false
      t.string :inboundURL, null: false
      t.string :outboundURL, null: false
      t.string :method, null: false
      t.integer :retries, null: false
      t.integer :delay, null: false
      t.references :user, foreign_key: true, null: false
      t.binary :payload, null: false

      t.timestamps
    end

    create_table :env_vars do |t|
      t.string :key, null: false
      t.string :value, null: false
      t.references :bridge, forgeign_key: true, null: false

      t.timestamps
    end

    create_table :headers do |t|
      t.string :value, null: false
      t.string :key, null: false
      t.references :bridge, forgeign_key: true, null: false

      t.timestamps
    end
    
    create_table :events do |t|
      t.boolean :completed
      t.binary :data
      t.string :inboundURL
      t.string :outboundURL
      t.integer :status_code
      t.datetime :completed_at
      t.references :bridge, forgeign_key: true, null: false

      t.timestamps
    end
  end
end
