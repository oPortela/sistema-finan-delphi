program MonolitoFinanceiro;

uses
  Vcl.Forms,
  finan.view.princ in 'src\view\finan.view.princ.pas' {frmPrincipal},
  finan.view.cadastroPadrao in 'src\view\finan.view.cadastroPadrao.pas' {formCadastroPadrao},
  finan.view.splash in 'src\view\finan.view.splash.pas' {frmSplash},
  sistema.model.conexao in 'src\Model\sistema.model.conexao.pas' {dmConexao: TDataModule},
  finan.view.Usuario in 'src\view\finan.view.Usuario.pas' {formUsuarios},
  sistema.model.usuarios in 'src\Model\sistema.model.usuarios.pas' {dmUsuarios: TDataModule},
  finan.Utilitarios in 'src\Util\finan.Utilitarios.pas',
  finan.view.Login in 'src\view\finan.view.Login.pas' {frmLogin},
  sistema.model.Entidades.usuarios in 'src\Model\Entidades\sistema.model.Entidades.usuarios.pas',
  sistema.model.sistema in 'src\Model\sistema.model.sistema.pas' {dmSistema: TDataModule},
  finan.view.RedefinirSenha in 'src\view\finan.view.RedefinirSenha.pas' {frmRedefinirSenha},
  sistema.model.Caixa in 'src\Model\sistema.model.Caixa.pas' {dmCaixa: TDataModule},
  finan.view.Caixa in 'src\view\finan.view.Caixa.pas' {frmCaixa},
  finan.view.Caixa.Saldo in 'src\view\finan.view.Caixa.Saldo.pas' {frmCaixaSaldo},
  sistema.model.Entidades.Caixa.Resumo in 'src\Model\Entidades\sistema.model.Entidades.Caixa.Resumo.pas',
  sistema.model.Contas.Pagar in 'src\Model\sistema.model.Contas.Pagar.pas' {dmContasPagar: TDataModule},
  finan.view.Contas.Pagar in 'src\view\finan.view.Contas.Pagar.pas' {frmContasPagar},
  sistema.model.Contas.Receber in 'src\Model\sistema.model.Contas.Receber.pas' {dmContasReceber: TDataModule},
  finan.view.Contas.Receber in 'src\view\finan.view.Contas.Receber.pas' {frmContasReceber};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TdmCaixa, dmCaixa);
  Application.CreateForm(TdmUsuarios, dmUsuarios);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TformCadastroPadrao, formCadastroPadrao);
  Application.CreateForm(TformUsuarios, formUsuarios);
  Application.CreateForm(TdmSistema, dmSistema);
  Application.CreateForm(TfrmCaixa, frmCaixa);
  Application.CreateForm(TfrmCaixaSaldo, frmCaixaSaldo);
  Application.CreateForm(TdmContasPagar, dmContasPagar);
  Application.CreateForm(TfrmContasPagar, frmContasPagar);
  Application.CreateForm(TdmContasReceber, dmContasReceber);
  Application.CreateForm(TfrmContasReceber, frmContasReceber);
  Application.Run;
end.
