inherited frmContasPagar: TfrmContasPagar
  Caption = 'Cadastro de Contas a Pagar'
  TextHeight = 21
  inherited PnlPrincipal: TCardPanel
    ActiveCard = cardCadastro
    inherited cardCadastro: TCard
      object Label2: TLabel [0]
        Left = 24
        Top = 27
        Width = 70
        Height = 21
        Caption = 'Descri'#231#227'o:'
      end
      object Label3: TLabel [1]
        Left = 24
        Top = 62
        Width = 107
        Height = 21
        Caption = 'N'#186' Documento:'
      end
      object Label4: TLabel [2]
        Left = 24
        Top = 97
        Width = 107
        Height = 21
        Caption = 'N'#186' Documento:'
      end
      object edtDescricao: TEdit
        Left = 160
        Top = 24
        Width = 329
        Height = 29
        TabOrder = 1
      end
      object edtNumeroDocumento: TEdit
        Left = 160
        Top = 59
        Width = 329
        Height = 29
        TabOrder = 2
      end
      object Edit2: TEdit
        Left = 160
        Top = 94
        Width = 329
        Height = 29
        TabOrder = 3
      end
    end
    inherited cardPesquisa: TCard
      inherited pnlGrid: TPanel
        inherited DBGrid1: TDBGrid
          Columns = <
            item
              Expanded = False
              FieldName = 'numero_documento'
              Title.Caption = 'N'#186' Documento'
              Width = 131
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'descricao'
              Title.Caption = 'Descri'#231#227'o'
              Width = 207
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'data_vencimento'
              Title.Caption = 'Data de Vencimento'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'status'
              Title.Caption = 'Status'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'parcela'
              Title.Caption = 'Parcela'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'valor_parcela'
              Title.Caption = 'Valor Parcela'
              Width = 111
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'valor_compra'
              Title.Caption = 'Valor Compra'
              Width = 110
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'valor_abatido'
              Title.Caption = 'Valor Abatido'
              Width = 115
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'data_compra'
              Title.Caption = 'Data da Compra'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'data_cadastro'
              Title.Caption = 'Data Cadastro'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'data_pagamento'
              Title.Caption = 'Data de Pagamento'
              Visible = True
            end>
        end
      end
    end
  end
  inherited ImageList1: TImageList
    Left = 632
  end
  inherited DataSource1: TDataSource
    DataSet = dmContasPagar.cdsContasPagar
  end
end
