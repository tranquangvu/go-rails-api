class CreateSessions < ActiveRecord::Migration[7.2]
  def change
    create_table :sessions, id: :uuid do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }, type: :uuid
      t.string :secret, null: false
      t.string :ip_address
      t.string :user_agent
      t.datetime :expired_at
      t.timestamps
    end
    add_index :sessions, :secret, unique: true
  end
end
