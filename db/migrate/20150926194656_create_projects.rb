class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :title_slug
      t.belongs_to :user, index: true
      t.boolean :show_in_dashboard

      t.timestamps null: false
    end
  end
end
