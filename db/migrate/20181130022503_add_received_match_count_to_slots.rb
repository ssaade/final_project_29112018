class AddReceivedMatchCountToSlots < ActiveRecord::Migration[5.1]
  def change
    add_column :slots, :received_matches_count, :integer
  end
end
