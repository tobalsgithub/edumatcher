class AddTimestamptsToCompaniesExperts < ActiveRecord::Migration
  def change
    change_table :companies_experts do |t|
      t.timestamps
    end
  end

  def down
    remove_column :companies_experts, :created_at
    remove_column :companies_experts, :updated_at
  end
end
