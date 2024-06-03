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
  finan.view.Caixa in 'src\view\finan.view.Caixa.pas' {frmCaixa};

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
  Application.Run;
end.
