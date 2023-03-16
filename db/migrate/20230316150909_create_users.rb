class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :clientName
      t.string :clientEmail

      t.timestamps
    end
  end
end
