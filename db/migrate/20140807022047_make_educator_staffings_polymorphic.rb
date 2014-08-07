class MakeEducatorStaffingsPolymorphic < ActiveRecord::Migration
  def change
    rename_column :educator_staffings, :classroom_id, :staffable_id
    add_column :educator_staffings, :staffable_type, :string
  end
end
