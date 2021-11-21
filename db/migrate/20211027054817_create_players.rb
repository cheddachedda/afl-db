class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :middle_initial
      t.string :last_name
      t.belongs_to :club
      t.string :position, :array => true, :default => []
    end
  end
end
