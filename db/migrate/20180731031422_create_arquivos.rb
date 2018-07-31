class CreateArquivos < ActiveRecord::Migration[5.2]
  def change
    create_table :arquivos do |t|
      t.string :name
      t.string :surname
      t.string :token
      t.string :email
      t.date :admission_date
      t.decimal :available_amount

      t.timestamps
    end
  end
end
