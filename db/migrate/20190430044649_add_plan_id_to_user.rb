class AddPlanIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :plan, index: true
  end
end
