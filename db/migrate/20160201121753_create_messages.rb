class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.boolean :msg_public
    	t.text :msg_to
    	t.string :subject
    	t.text :content
    	t.integer :like_count
    	t.integer :comment_count
    	t.string :delivery_date
    	t.string :delivery_time

    	t.timestamps null: false
    end
  end
end
