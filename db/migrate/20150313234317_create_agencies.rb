class CreateAgencies < ActiveRecord::Migration
  def change
    create_table :agencies do |t|
      t.string :name
      t.integer :organization_id

      t.timestamps null: false
    end
  end
end
