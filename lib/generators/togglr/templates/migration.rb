#encoding: utf-8

class CreateTogglrToggles < ActiveRecord::Migration
  def up
    create_table :togglr_toggles, :id => false do |t|
      t.string :name, :unique => true, :null => false
      t.boolean :value

      t.timestamps
    end

    execute 'ALTER TABLE togglr_toggles ADD PRIMARY KEY (name)'
    add_index :togglr_toggles, :name, :unique => true
  end

  def down
    remove_index :togglr_toggles, :name
    drop_table :togglr_toggles
  end
end
