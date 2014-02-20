#encoding: utf-8

class CreateTogglrToggles < ActiveRecord::Migration
  def change
    create_table :togglr_toggles do |t|
      t.string :name
      t.boolean :value

      t.timestamps
    end
  end
end
