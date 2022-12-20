class AddReceiverClassToMessage < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :receiver_class, :string
  end
end
