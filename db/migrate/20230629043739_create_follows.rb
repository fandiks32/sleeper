class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.references :follower, foreign_key: true
      t.references :following, foreign_key: true

      t.timestamps
    end
    add_foreign_key :follower, :users, column: :follower_id
    add_foreign_key :following, :users, column: :following_id
  end
end
