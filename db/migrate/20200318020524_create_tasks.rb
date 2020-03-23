class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, limit: 30, null: false
      t.text :content

      t.timestamps
    end
  end
end
