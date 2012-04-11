class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :landmark_id
      t.integer :location_id
      t.integer :duration

      t.timestamps
    end
  end
end
