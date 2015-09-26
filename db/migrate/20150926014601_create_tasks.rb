class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.belongs_to :user, index: true
      t.datetime :completed_at
      t.datetime :time_spent

      t.timestamps null: false
    end
  end
end
