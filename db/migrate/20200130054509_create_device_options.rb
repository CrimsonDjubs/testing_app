class CreateDeviceOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :device_options do |t|
      t.integer :option_id
      t.integer :device_id
    end

    add_index :device_options, :option_id
    add_index :device_options, :device_id
    add_index :device_options, %i(option_id device_id), unique: true 
  end
end
