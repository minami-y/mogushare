class AddStripeColumnsToSellers < ActiveRecord::Migration[5.0]
  def change
    add_column :sellers, :postal_code, :string
    add_column :sellers, :address_kana_state, :string
    add_column :sellers, :address_kana_city, :string
    add_column :sellers, :address_kana_town, :string
    add_column :sellers, :address_kana_line, :string
    add_column :sellers, :address_kanji_state, :string
    add_column :sellers, :address_kanji_city, :string
    add_column :sellers, :address_kanji_town, :string
    add_column :sellers, :address_kanji_line, :string
    add_column :sellers, :date_of_birth, :date
    add_column :sellers, :first_name_kana, :string
    add_column :sellers, :last_name_kana, :string
    add_column :sellers, :first_name_kanji, :string
    add_column :sellers, :last_name_kanji, :string
    add_column :sellers, :phone_number, :string
    add_column :sellers, :gender, :integer
  end
end
