class AddIdToCompaniesExperts < ActiveRecord::Migration
  def change
    add_column :companies_experts, :id, :integer
  end
end
