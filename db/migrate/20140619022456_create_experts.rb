class CreateExperts < ActiveRecord::Migration
  def change
    create_table :experts do |t|
      t.text :notes

      t.timestamps
    end
  end
end
