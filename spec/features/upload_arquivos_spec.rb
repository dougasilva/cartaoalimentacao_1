require 'rails_helper'

RSpec.feature 'UploadArquivos', type: :feature do
  scenario 'Upload de arquivo válido' do
    
    visit new_arquivo_path
    page.attach_file('file', Rails.root.join('spec', 'fixtures', 'dados-20-07-2018.csv'))
    click_on('Importar')

    expect(page).to have_content 'Dados Importados' 
  end

  scenario 'Nã faz upload de arquivo inválido' do
    visit new_arquivo_path
    click_on('Importar')

    expect(page).to have_content 'Selecione um arquivo' 
  end
end
