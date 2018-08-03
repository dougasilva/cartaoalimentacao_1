class ArquivosController < ApplicationController
 
  def index
    @funcionariosAntigos = Arquivo.funcionarioAntigo.page params[:antigo]
    @funcionariosNovos = Arquivo.funcionarioNovo.page params[:novo]
  end

  def new
    
  end

  def import
    if params[:file]
      Arquivo.import(params[:file])
      redirect_to arquivos_path, notice: "Dados Importados."
    else
      redirect_to new_arquivo_path, notice: "Selecione um arquivo."
    end
  end

  private
  def arquivo_params
    params.require(:arquivo).permit(:file)
  end

end
