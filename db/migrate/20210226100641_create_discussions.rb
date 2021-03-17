class CreateDiscussions < ActiveRecord::Migration[6.0]
  def change
    create_table :discussions do |t|
      t.string :description
      t.string :topic

      t.timestamps
    end
  end
end
