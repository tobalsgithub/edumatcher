class CreateEducatorsSchools < ActiveRecord::Migration
  def change
    create_table :educators_schools do |t|
      t.references :educator, index: true
      t.references :school, index: true
    end
  end
end
