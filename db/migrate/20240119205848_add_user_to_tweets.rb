class AddUserToTweets < ActiveRecord::Migration[6.1]
  def change
    add_reference :tweets, :user
  end
end
