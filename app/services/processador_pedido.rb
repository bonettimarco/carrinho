# frozen_string_literal: true

class ProcessadorPedido
  attr_reader :itens, :forma_pagamento, :sessao

  def initialize(carga_id)
    session[:carrinho] ||= @carrinho = Carga.find_by(id: carga_id)
    @usuario = @carga.autor if @carga.present?
    PaperTrail.request.whodunnit = @usuario
    self


  end

  def cria_carrega_carrinho
  end

  def processar
    if @carrinho.present? && @carrinho.aguardando_processamento?
      if true || checa_arquivo
        ActiveRecord::Base.transaction do
          importar
          atualizar_carga
          raise ActiveRecord::Rollback if carga.errors.any?
          comunica_erro_arquivo if carga.errors.any?
        end
        enviar_email unless carga.errors.any?
      end
    end

  end
  private

  def importar
    @importador = Importacoes::Carga.new(carga.id)
    comunica_erro_arquivo if @importador.errors.any?
    importador.importar
  end

  def atualizar_carga
    data_atual = Date.current
    return carga.update(situacao: :falha,
                        data_processamento: data_atual,
                        erros: importador.errors.full_messages.join(', ') ) if importador.errors.any?
    carga.update(situacao: :concluida,
                 data_processamento: data_atual,
                 total_importado: importador.total_importado,
                 erros: '')

  end

  def enviar_email
    # CargaMailer.with(carga: @carga,
    #                  usuario: @usuario).notificar.deliver_later
  end

  # Testa se o arquivo está disponível para ser processado
  def checa_arquivo
    # begin
    #   carga.arquivo.download
    #   return true
    # rescue
    #   comunica_erro_arquivo
    #   return false
    # end
  end

  def comunica_erro_arquivo
    data_atual = Date.current
    carga.update(situacao: :falha,
                 data_processamento: data_atual,
                 erros: "Houve algum problema com o arquivo anexado, favor tentar novamente. No caso de (xlsx, xlsm) salve como Excel 2007-2013.")
  end
end