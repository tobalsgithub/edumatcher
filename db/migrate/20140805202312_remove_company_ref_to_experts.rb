class RemoveCompanyRefToExperts < ActiveRecord::Migration
  def change
    remove_column :experts, :company_id
  end
end
