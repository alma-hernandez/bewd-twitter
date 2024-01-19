class AddTokenToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :token, integer
  end
end
