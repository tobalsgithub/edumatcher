class CreateEducatorsSchoolDistricts < ActiveRecord::Migration
  def change
    create_table :educators_school_districts do |t|
      t.references :educator, index: true
      t.references :SchoolDistrict, index: true
    end
  end
end
