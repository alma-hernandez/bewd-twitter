class AddTokenToSessions < ActiveRecord::Migration[6.1]
  def change
    add_column :sessions, :token, :integer
  end
end
