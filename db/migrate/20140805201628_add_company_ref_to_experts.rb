class AddCompanyRefToExperts < ActiveRecord::Migration
  def change
    add_reference :experts, :company, index: true
  end
end
