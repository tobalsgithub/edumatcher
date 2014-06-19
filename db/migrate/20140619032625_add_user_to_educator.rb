class AddUserToEducator < ActiveRecord::Migration
  def change
    add_reference :educators, :user, index: true
  end
end
