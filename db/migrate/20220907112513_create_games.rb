class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :title
      t.string :genre
      t.string :platform
      t.string :short_description
      t.string :thumbnail
      t.string :publisher
      t.string :game_url
      t.integer :price

      t.timestamps
    end
  end
end