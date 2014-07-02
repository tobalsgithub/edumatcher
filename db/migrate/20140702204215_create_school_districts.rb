class CreateSchoolDistricts < ActiveRecord::Migration
  def change
    create_table :school_districts do |t|
      t.string :name
      t.string :website
      t.string :location
      t.text :notes
      t.timestamps
    end
  end
end
