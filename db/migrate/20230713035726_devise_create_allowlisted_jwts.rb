class DeviseCreateAllowlistedJwts < ActiveRecord::Migration[7.0]
  def change
    create_table :allowlisted_jwts do |t|
      t.string :jti, null: false
      t.string :aud, null: true
      t.datetime :exp, null: false
      t.references :user, type: :uuid, foreign_key: { on_delete: :cascade }, null: false
    end
    add_index :allowlisted_jwts, :jti, unique: true
  end
end
