class CreateOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :options do |t|
      t.integer :experiment_id
      t.decimal :percent, precision: 2
      t.string :value
    end

    add_index :options, :experiment_id
  end
end
