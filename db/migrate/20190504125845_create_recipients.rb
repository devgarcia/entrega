class CreateRecipients < ActiveRecord::Migration[5.2]
  def change
    create_table :recipients do |t|
      t.string :name
      t.string :telephone
      t.string :email
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end