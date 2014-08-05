class CreateJoinTableExpertCompany < ActiveRecord::Migration
  def change
    create_join_table :experts, :companies do |t|
      t.index [:expert_id, :company_id]
      t.index [:company_id, :expert_id]
    end
  end
end
