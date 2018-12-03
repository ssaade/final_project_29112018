class ToDatetime < ActiveRecord::Migration[5.1]
  def change

    change_column :slots, :start_time, :datetime
    change_column :slots, :end_time, :datetime
    change_column :matches, :start_time, :datetime
    change_column :matches, :end_time, :datetime

  end
end
