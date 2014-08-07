class AddIdToCompaniesExperts < ActiveRecord::Migration
  def change
    add_column :companies_experts, :id, :primary_key
  end
end
