class Arquivo < ApplicationRecord
  validates :name, :surname, presence: true, length: { maximum:50 }
  validates :available_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                              on: :create }, presence: true
  
  require 'csv'
  paginates_per 5

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      arquivo_hash = row.to_hash
      arquivo = Arquivo.where( name: arquivo_hash['name'], 
                               surname: arquivo_hash['surname'] )
      ad_date = validaData(arquivo_hash['admission_date'])
      arquivo_hash['admission_date'] = Date.parse(ad_date)
      
      if arquivo.count == 1
        arquivo.first.update_attributes(arquivo_hash)
      else
        arquivo.create!(arquivo_hash)
      end
    end
  end

  def self.validaData(data)
    n_data = "#{ data[6..7] }/#{ data[3..4] }/#{ data[0..1] }"
  end

  def self.funcionarioAntigo 
    Arquivo.where("strftime('%Y-%m/%d',admission_date) < ?", 1.year.ago)
  end

  def self.funcionarioNovo 
    Arquivo.where("strftime('%Y-%m/%d',admission_date) > ?", 1.year.ago)
  end
end
