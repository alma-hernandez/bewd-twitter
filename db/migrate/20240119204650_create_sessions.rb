class CreateSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions do |t|

      t.string        :token
      t.integer       :user_id, foreign_key: true



      t.timestamps      null: false
    end

    add_index :sessions, :user_id
  end
end
