#encoding: utf-8

class CreateTogglrToggles < ActiveRecord::Migration
  def change
    create_table :togglr_toggles do |t|
      t.string :name, :unique => true, :null => false
      t.boolean :value, :null => false

      t.timestamps
    end

    add_index :togglr_toggles, :name, :unique => true
  end
end
