class CreateCaves < ActiveRecord::Migration[7.0]
  def change
    create_table :caves do |t|
      t.string :name
      t.integer :latitude
      t.integer :longitude
    end
  end
end
