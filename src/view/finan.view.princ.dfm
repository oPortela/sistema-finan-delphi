object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Sistema Financeiro'
  ClientHeight = 468
  ClientWidth = 630
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  TextHeight = 15
  object StatusBar1: TStatusBar
    Left = 0
    Top = 449
    Width = 630
    Height = 19
    Panels = <
      item
        Width = 150
      end
      item
        Width = 300
      end>
  end
  object MainMenu1: TMainMenu
    Left = 512
    Top = 24
    object menuCadastro: TMenuItem
      Caption = 'Cadastro'
      object mnuUsuarios: TMenuItem
        Caption = 'Usu'#225'rios'
        OnClick = mnuUsuariosClick
      end
    end
    object Financeiro1: TMenuItem
      Caption = 'Financeiro'
      object mnuCaixa: TMenuItem
        Caption = 'Caixa'
        OnClick = mnuCaixaClick
      end
      object mnuContasPagar: TMenuItem
        Caption = 'Contas a Pagar'
        OnClick = mnuContasPagarClick
      end
      object mnuContasReceber: TMenuItem
        Caption = 'Contas Receber'
        OnClick = mnuContasReceberClick
      end
      object mnuContasReceberConsultar: TMenuItem
        Caption = 'Consultar Contas a Receber'
        OnClick = mnuContasReceberConsultarClick
      end
      object mnuContasPagarConsultar: TMenuItem
        Caption = 'Consultar Contas a Pagar'
        OnClick = mnuContasPagarConsultarClick
      end
    end
    object mnuRelatorios: TMenuItem
      Caption = 'Relat'#243'rios'
      object mnuResumoCaixa: TMenuItem
        Caption = 'Resumo do Caixa'
        OnClick = mnuResumoCaixaClick
      end
    end
    object mnuAjuda: TMenuItem
      Caption = 'Ajuda'
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 560
    Top = 352
  end
end
