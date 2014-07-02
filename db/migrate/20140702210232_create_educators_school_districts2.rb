class CreateEducatorsSchoolDistricts2 < ActiveRecord::Migration
  def change
    create_table :educators_school_districts do |t|
      t.references :educator, index: true
      t.references :school_district, index: true
    end
  end
end
