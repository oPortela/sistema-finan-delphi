unit finan.view.princ;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    menuCadastro: TMenuItem;
    mnuRelatorios: TMenuItem;
    mnuAjuda: TMenuItem;
    mnuUsuarios: TMenuItem;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    Financeiro1: TMenuItem;
    mnuCaixa: TMenuItem;
    mnuResumoCaixa: TMenuItem;
    mnuContasPagar: TMenuItem;
    mnuContasReceber: TMenuItem;
    mnuContasReceberConsultar: TMenuItem;
    mnuContasPagarConsultar: TMenuItem;
    procedure menuCadastroPadraoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mnuUsuariosClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure mnuCaixaClick(Sender: TObject);
    procedure mnuResumoCaixaClick(Sender: TObject);
    procedure mnuContasPagarClick(Sender: TObject);
    procedure mnuContasReceberClick(Sender: TObject);
    procedure mnuContasReceberConsultarClick(Sender: TObject);
    procedure mnuContasPagarConsultarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  finan.view.cadastroPadrao,
  finan.view.splash, finan.view.Usuario, finan.view.Login,
  sistema.model.usuarios, finan.view.RedefinirSenha, finan.view.Caixa,
  finan.view.Caixa.Saldo, finan.view.Contas.Pagar, finan.view.Contas.Receber,
  finan.view.Contas.Receber.Consultar, finan.view.Contas.Pagar.Consultar;

{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  frmSplash := TfrmSplash.Create(nil);
  try
    frmSplash.ShowModal;
  finally
    FreeAndNil(frmSplash);
  end;

  frmLogin := TfrmLogin.Create(nil);
  try
    frmLogin.ShowModal;
    if frmLogin.ModalResult <> mrOk then
      Application.Terminate;
  finally
    FreeAndNil(frmLogin)
  end;

  if dmUsuarios.GetUsuarioLogado.SenhaTemporaria  then
  begin
    frmRedefinirSenha := TfrmRedefinirSenha.Create(nil);
    try
      frmRedefinirSenha.Usuario := dmUsuarios.GetUsuarioLogado;
      frmRedefinirSenha.ShowModal;
      if frmRedefinirSenha.ModalResult <> mrOk then
        Application.Terminate;

    finally
      FreeAndNil(frmRedefinirSenha);
    end;
  end;

  StatusBar1.Panels.Items[1].Text := 'Usu�rio: ' + dmUsuarios.GetUsuarioLogado.Nome;
end;

procedure TfrmPrincipal.menuCadastroPadraoClick(Sender: TObject);
begin
  formCadastroPadrao.Show;
end;

procedure TfrmPrincipal.mnuCaixaClick(Sender: TObject);
begin
  frmCaixa.Show;
end;

procedure TfrmPrincipal.mnuContasPagarClick(Sender: TObject);
begin
  frmContasPagar.Show;
end;

procedure TfrmPrincipal.mnuContasPagarConsultarClick(Sender: TObject);
begin
  frmConsultarContasPagar.Show;
end;

procedure TfrmPrincipal.mnuContasReceberClick(Sender: TObject);
begin
  frmContasReceber.Show;
end;

procedure TfrmPrincipal.mnuContasReceberConsultarClick(Sender: TObject);
begin
  frmConsultarContasReceber.Show;
end;

procedure TfrmPrincipal.mnuResumoCaixaClick(Sender: TObject);
begin
  frmCaixaSaldo.Show;
end;

procedure TfrmPrincipal.mnuUsuariosClick(Sender: TObject);
begin
  formUsuarios.Show;
end;

procedure TfrmPrincipal.Timer1Timer(Sender: TObject);
begin
  StatusBar1.Panels.Items[0].Text := DateTimeToStr(Now);
end;

end.
