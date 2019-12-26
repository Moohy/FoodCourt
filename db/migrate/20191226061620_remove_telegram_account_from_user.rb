class RemoveTelegramAccountFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :telegram_account, :string
  end
end
