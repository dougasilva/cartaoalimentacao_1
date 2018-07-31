class Arquivo < ApplicationRecord
  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      arquivo_hash = row.to_hash
      arquivo = Arquivo.where( name: arquivo_hash['name'], 
                               surname: arquivo_hash['surname'] )

      if arquivo.count == 1
        arquivo.first.update_attributes(arquivo_hash)
      else
        arquivo.create!(arquivo_hash)
      end
    end
  end
end
