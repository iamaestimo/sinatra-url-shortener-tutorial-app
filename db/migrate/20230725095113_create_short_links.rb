class CreateShortLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :short_links do |t|
      t.string :short_url
      t.string :long_url
      t.integer :visits, default: 0

      t.timestamps
    end
    add_index :short_links, %i[short_url long_url]
  end
end
