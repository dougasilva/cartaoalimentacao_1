class Arquivo < ApplicationRecord
  validates :name, :surname, presence: true, length: { maximum:50 }
  validates :available_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                              on: :create }, presence: true
  
  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      arquivo_hash = row.to_hash
      arquivo = Arquivo.where( name: arquivo_hash['name'], 
                               surname: arquivo_hash['surname'] )
      ad_date = ValidaData(arquivo_hash['admission_date'])
      arquivo_hash['admission_date'] = Date.parse(ad_date)
      
      if arquivo.count == 1
        arquivo.first.update_attributes(arquivo_hash)
      else
        arquivo.create!(arquivo_hash)
      end
    end
  end

  def self.ValidaData(data)
    dia = data[0..1]
    mes = data[3..4]
    ano = data[6..7]
    n_data = "#{ano}/#{mes}/#{dia}"
  end
end
