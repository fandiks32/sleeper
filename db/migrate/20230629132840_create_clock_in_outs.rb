class CreateClockInOuts < ActiveRecord::Migration[5.2]
  def change
    create_table :clock_in_outs do |t|
      t.references :user, foreign_key: true
      t.integer :duration_ms
      t.datetime :clock_in
      t.datetime :clock_out
      t.date :target_date

      t.timestamps
    end
  end
end
