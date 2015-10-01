class CreateViewFiles < ActiveRecord::Migration
  def change
    create_table :view_files do |t|

      t.timestamps null: false
    end
  end
end
