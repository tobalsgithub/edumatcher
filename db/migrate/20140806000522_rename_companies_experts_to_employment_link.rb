class RenameCompaniesExpertsToEmploymentLink < ActiveRecord::Migration
  def change
    rename_table :companies_experts, :employment_link
  end
end
