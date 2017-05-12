class CreateInterests < ActiveRecord::Migration[5.0]
  def change
    create_table :interests do |t|
      t.references :tag, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
