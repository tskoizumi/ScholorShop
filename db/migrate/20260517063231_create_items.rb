class CreateItems < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :point, default: 0
      t.boolean :admin, default: false
      
      t.timestamps
    end
   create_table :items do |t|
      t.string :name
      t.integer :user_id
      t.integer :buyer_id
      t.string :explanation
      t.integer :price
      t.integer :status, default: 0
      t.string :locker_pass
      t.string :image
      
      t.timestamps
    end
   create_table :chats do |t|
      t.integer :item_id
      t.integer :user_id
      t.string :message

      t.timestamps
    end

  end
end