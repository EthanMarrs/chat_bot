class AddFromEnum < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :from, :integer
  end
end
