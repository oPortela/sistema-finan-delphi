object dmUsuarios: TdmUsuarios
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 480
  Width = 640
  object cdsUsuarios: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspUsuarios'
    Left = 360
    Top = 64
    object cdsUsuariosID: TStringField
      FieldName = 'ID'
      Size = 36
    end
    object cdsUsuariosNome: TStringField
      FieldName = 'Nome'
      Size = 50
    end
    object cdsUsuariosLogin: TStringField
      FieldName = 'Login'
    end
    object cdsUsuariosSenha: TStringField
      FieldName = 'Senha'
      Size = 60
    end
    object cdsUsuariosStatus: TStringField
      FieldName = 'Status'
      Size = 1
    end
    object cdsUsuariosDataCadastro: TDateField
      FieldName = 'data_cadastro'
    end
    object cdsUsuariossenha_temporaria: TStringField
      FieldName = 'senha_temporaria'
      Size = 1
    end
  end
  object dspUsuarios: TDataSetProvider
    DataSet = sqlUsuarios
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 288
    Top = 64
  end
  object sqlUsuarios: TFDQuery
    Connection = dmConexao.SQLConexao
    Left = 208
    Top = 64
  end
end
