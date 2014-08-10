class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :rating
      t.string :title
      t.string :notes
      t.belongs_to :user
      t.references :ratable, polymorphic: true

      t.timestamps
    end
  end
end
