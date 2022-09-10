class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.string :comment
      t.integer :rating
      t.integer :user_id
      t.integer :game_id # this is our foreign key
      t.timestamps
    end
  end
end

