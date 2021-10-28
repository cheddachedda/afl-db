class CreateClubs < ActiveRecord::Migration[6.1]
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :abbreviation
      t.string :fixtures_alias
      t.string :afl_tables_alias
    end
  end
end
