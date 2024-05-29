unit finan.view.Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls;

type
  TfrmLogin = class(TForm)
    pnlEsquerda: TPanel;
    imgLogo: TImage;
    pnlPrincipal: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    lblNomeAplicacao: TLabel;
    Label1: TLabel;
    pnlSenha: TPanel;
    Label3: TLabel;
    edtSenha: TEdit;
    pnlUsuario: TPanel;
    Label2: TLabel;
    edtLogin: TEdit;
    btnEntrar: TButton;
    procedure btnEntrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  sistema.model.usuarios, sistema.model.sistema;

{$R *.dfm}

procedure TfrmLogin.btnEntrarClick(Sender: TObject);
begin
  if Trim(edtLogin.Text) = '' then
  begin
    edtLogin.SetFocus;
    Application.MessageBox('Informe o seu usu�rio.', 'Aten��o', MB_OK + MB_ICONWARNING);
    Abort;
  end;

  if Trim(edtSenha.Text) = '' then
  begin
    edtSenha.SetFocus;
    Application.MessageBox('Informe a sua senha.', 'Aten��o', MB_OK + MB_ICONWARNING);
    Abort;
  end;

  try
    dmUsuarios.efetuarLogin(Trim(edtLogin.Text), Trim(edtSenha.Text));
    dmSistema.DataUltimoAcesso(Now);
    dmSistema.UsuarioUltimoAcesso(dmUsuarios.GetUsuarioLogado.Login);
    ModalResult := mrOk;
  except
    on Erro: Exception do
    begin
      Application.MessageBox(PwideChar(Erro.Message), 'Aten��o', MB_OK + MB_ICONWARNING);
      edtLogin.SetFocus;
    end;
  end;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  edtLogin.Text := dmSistema.UsuarioUltimoAcesso;
end;

end.
