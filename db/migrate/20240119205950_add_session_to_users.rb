class AddSessionToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :session
  end
end
