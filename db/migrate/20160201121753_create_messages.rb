class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
        t.references :user, index: true

    	t.boolean :msg_public, :default => false
    	t.text :msg_to
    	t.string :subject
    	t.text :content
    	t.integer :like_count, :default => 0
    	t.integer :comment_count, :default => 0
    	t.string :delivery_date
    	t.string :delivery_time

    	t.timestamps null: false
    end
  end
end
