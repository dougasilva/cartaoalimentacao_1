class ArquivosController < ApplicationController
 
  def index
    @arquivos = Arquivo.all
  end

  def new
    
  end

  def import
    if params[:file]
      Arquivo.import(params[:file])
      redirect_to root_url, notice: "Dados Importados."
    else
      redirect_to new_arquivo_path, notice: "Selecione um arquivo."
    end
  end

  private
  def arquivo_params
    params.require(:arquivo).permit(:file)
  end

end
