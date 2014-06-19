class CreateSchoolDistricts < ActiveRecord::Migration
  def change
    create_table :school_districts do |t|
      t.string :website
      t.string :location

      t.timestamps
    end
  end
end
