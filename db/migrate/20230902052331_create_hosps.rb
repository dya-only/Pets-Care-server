class CreateHosps < ActiveRecord::Migration[7.0]
  def change
    create_table :hosps do |t|
      t.string :name
      t.integer :latitude
      t.integer :longitude
    end
  end
end
