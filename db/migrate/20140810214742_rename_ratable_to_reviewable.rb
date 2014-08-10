class RenameRatableToReviewable < ActiveRecord::Migration
  def change
    rename_column :reviews, :ratable_id, :reviewable_id
    rename_column :reviews, :ratable_type, :reviewable_type
  end
end
