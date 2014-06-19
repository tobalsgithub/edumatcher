class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :website
      t.string :location
      t.references :SchoolDistrict, index: true

      t.timestamps
    end
  end
end
