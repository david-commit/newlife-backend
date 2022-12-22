class AddSenderClassToMessage < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :sender_class, :string
  end
end
