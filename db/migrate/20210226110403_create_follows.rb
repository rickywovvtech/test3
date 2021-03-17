class CreateFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows do |t|
      t.references :user
      t.integer :sessionuser

      t.timestamps
    end
  end
end
