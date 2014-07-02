class RemoveSchoolDistrictColumns < ActiveRecord::Migration
  def change
    remove_column :schools, :SchoolDistrict_id
    remove_column :schools, :school_district_id
  end
end
