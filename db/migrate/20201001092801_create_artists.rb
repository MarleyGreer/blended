class CreateArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :artists do |t|
      t.string :description
      t.string :qualifications
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
