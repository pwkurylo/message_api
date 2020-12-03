class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.binary :message
      t.datetime :read_at
      t.boolean :password, default: false
      t.string :uniq_key, unique: true

      t.timestamps
    end
  end
end
