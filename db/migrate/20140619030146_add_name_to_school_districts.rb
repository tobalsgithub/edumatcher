class AddNameToSchoolDistricts < ActiveRecord::Migration
  def change
    add_column :school_districts, :name, :string
  end
end
