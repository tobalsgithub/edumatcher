class AddSchoolDistrictRefToSchool2 < ActiveRecord::Migration
  def change
    add_reference :schools, :school_district, index: true
  end
end
