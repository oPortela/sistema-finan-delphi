inherited frmContasReceber: TfrmContasReceber
  Caption = 'Cadastro Contas a Receber'
  TextHeight = 21
  inherited PnlPrincipal: TCardPanel
    inherited cardPesquisa: TCard
      inherited pnlGrid: TPanel
        inherited DBGrid1: TDBGrid
          Columns = <
            item
              Expanded = False
              FieldName = 'numero_documento'
              Title.Caption = 'N'#186' Documento'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'data_venda'
              Title.Caption = 'Data Venda'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'valor_venda'
              Title.Caption = 'Valor da Venda'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'descricao'
              Title.Caption = 'Descri'#231#227'o'
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
              Title.Caption = 'Valor Da Parcela'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'valor_abatido'
              Title.Caption = 'Valor Abatido'
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
              FieldName = 'data_vencimento'
              Title.Caption = 'Data Vencimento'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'data_recebimento'
              Title.Caption = 'Data Recebimento'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'status'
              Title.Caption = 'Status'
              Visible = True
            end>
        end
      end
    end
  end
  inherited DataSource1: TDataSource
    DataSet = dmContasReceber.cdsContasReceber
  end
end