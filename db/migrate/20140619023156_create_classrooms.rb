class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.string :website
      t.string :location
      t.references :School, index: true
      t.text :notes

      t.timestamps
    end
  end
end
