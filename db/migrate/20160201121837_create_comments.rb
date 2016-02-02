class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.references :message, index: true
    	t.references :user, index: true

    	t.text :content
    	t.integer :plus_count, :default => 0

    	t.timestamps null: false
    end
  end
end