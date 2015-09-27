class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.belongs_to :user, index: true
      t.datetime :completed_at
      t.integer :worked_time_minutes
      t.integer :worked_time_seconds

      t.timestamps null: false
    end
  end
end
