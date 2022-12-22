class AddSenderIdToMessage < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :sender_id, :bigint
  end
end
