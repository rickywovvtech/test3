class AddUserToDiscussion < ActiveRecord::Migration[6.0]
  def change
    add_reference :discussions, :user, foreign_key: true
  end
end
