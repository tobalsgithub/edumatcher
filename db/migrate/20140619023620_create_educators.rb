class CreateEducators < ActiveRecord::Migration
  def change
    create_table :educators do |t|
      t.text :notes

      t.timestamps
    end
  end
end
