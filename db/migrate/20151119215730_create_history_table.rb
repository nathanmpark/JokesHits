class CreateHistoryTable < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :message
      t.references :contact
      t.references :user
      t.timestamps
    end
  end
end
