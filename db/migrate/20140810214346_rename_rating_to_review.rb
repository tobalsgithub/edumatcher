class RenameRatingToReview < ActiveRecord::Migration
  def change
    rename_table :ratings, :reviews
  end
end
