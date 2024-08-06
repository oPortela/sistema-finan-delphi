object dmContasPagar: TdmContasPagar
  Height = 480
  Width = 640
  object cdsContasPagar: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    ProviderName = 'dspContasPagar'
    Left = 408
    Top = 64
    object cdsContasPagarid: TStringField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 36
    end
    object cdsContasPagarnumero_documento: TStringField
      FieldName = 'numero_documento'
      Origin = 'numero_documento'
      Required = True
    end
    object cdsContasPagardescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Size = 200
    end
    object cdsContasPagarparcela: TIntegerField
      FieldName = 'parcela'
      Origin = 'parcela'
      Required = True
    end
    object cdsContasPagarvalor_parcela: TFMTBCDField
      FieldName = 'valor_parcela'
      Origin = 'valor_parcela'
      Required = True
      Precision = 18
      Size = 2
    end
    object cdsContasPagarvalor_compra: TFMTBCDField
      FieldName = 'valor_compra'
      Origin = 'valor_compra'
      Required = True
      Precision = 18
      Size = 2
    end
    object cdsContasPagarvalor_abatido: TFMTBCDField
      FieldName = 'valor_abatido'
      Origin = 'valor_abatido'
      Required = True
      Precision = 18
      Size = 2
    end
    object cdsContasPagardata_compra: TDateField
      FieldName = 'data_compra'
      Origin = 'data_compra'
      Required = True
    end
    object cdsContasPagardata_cadastro: TDateField
      FieldName = 'data_cadastro'
      Origin = 'data_cadastro'
      Required = True
    end
    object cdsContasPagardata_vencimento: TDateField
      FieldName = 'data_vencimento'
      Origin = 'data_vencimento'
      Required = True
    end
    object cdsContasPagardata_pagamento: TDateField
      FieldName = 'data_pagamento'
      Origin = 'data_pagamento'
    end
    object cdsContasPagarstatus: TStringField
      FieldName = 'status'
      Origin = 'status'
      Required = True
      FixedChar = True
      Size = 1
    end
    object cdsContasPagarTotal: TAggregateField
      FieldName = 'Total'
      Active = True
      DisplayName = ''
      Expression = 'SUM(VALOR_PARCELA)'
    end
  end
  object dspContasPagar: TDataSetProvider
    DataSet = sqlContasPagar
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 304
    Top = 64
  end
  object sqlContasPagar: TFDQuery
    Connection = dmConexao.SQLConexao
    SQL.Strings = (
      'select * from contas_pagar')
    Left = 192
    Top = 64
  end
  object sqlPagarDetalhes: TFDQuery
    AggregatesActive = True
    Connection = dmConexao.SQLConexao
    SQL.Strings = (
      'SELECT * FROM CONTAS_RECEBER_DETALHES')
    Left = 200
    Top = 160
    object sqlPagarDetalhesid: TStringField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 36
    end
    object sqlPagarDetalhesid_conta_receber: TStringField
      FieldName = 'id_contas_pagar'
      Origin = 'id_contas_pagar'
      Required = True
      Visible = False
      FixedChar = True
      Size = 36
    end
    object sqlPagarDetalhesdetalhes: TStringField
      DisplayLabel = 'Detalhes'
      FieldName = 'detalhes'
      Origin = 'detalhes'
      Required = True
      Size = 200
    end
    object sqlPagarDetalhesvalor: TFMTBCDField
      DisplayLabel = 'Valor Abatido'
      FieldName = 'valor'
      Origin = 'valor'
      Required = True
      DisplayFormat = 'R$ 0.00;R$ -0.00;'
      Precision = 18
      Size = 2
    end
    object sqlPagarDetalhesdata: TDateField
      DisplayLabel = 'Data da Baixa'
      FieldName = 'data'
      Origin = 'data'
      Required = True
    end
    object sqlPagarDetalhesusuario: TStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'usuario'
      Origin = 'usuario'
      Required = True
      Size = 50
    end
    object sqlPagarDetalhesNome: TStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'Nome'
      Size = 50
    end
    object sqlPagarDetalhesTotal: TAggregateField
      FieldName = 'Total'
      Active = True
      DisplayName = ''
      Expression = 'SUM(VALOR)'
    end
  end
end
