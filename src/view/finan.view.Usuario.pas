unit finan.view.Usuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, finan.view.cadastroPadrao, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.WinXPanels, sistema.model.usuarios, Vcl.WinXCtrls, Vcl.Menus;

type
  TformUsuarios = class(TformCadastroPadrao)
    btnLimpar: TButton;
    edtNome: TEdit;
    edtLogin: TEdit;
    ToggleStatus: TToggleSwitch;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    PopupMenu1: TPopupMenu;
    mnuLimparSenha: TMenuItem;
    procedure btnLimparClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure mnuLimparSenhaClick(Sender: TObject);
  private
    { Private declarations }
    function LimparString(Const Astr: String) : String;
  public
    { Public declarations }
    protected
      procedure Pesquisar; override;
  end;

var
  formUsuarios: TformUsuarios;

implementation

uses
  finan.Utilitarios, FireDAC.Comp.Client, System.SysUtils, BCrypt;

{$R *.dfm}

procedure TformUsuarios.btnAlterarClick(Sender: TObject);
begin
  inherited;
  edtNome.Text := dmUsuarios.cdsUsuariosNome.AsString;
  edtLogin.Text := dmUsuarios.cdsUsuariosLogin.AsString;
  //edtSenha.Text := dmUsuarios.cdsUsuariosSenha.AsString;

  ToggleStatus.State := tssOn;
  if dmUsuarios.cdsUsuariosStatus.AsString = 'B' then
    ToggleStatus.State := tssOff;
end;

procedure TformUsuarios.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dmUsuarios.cdsUsuarios.Insert;
end;

procedure TformUsuarios.btnLimparClick(Sender: TObject);
begin
  inherited;
  dmUsuarios.cdsUsuarios.Close;
  edtPesquisar.Clear;
end;

procedure TformUsuarios.btnSalvarClick(Sender: TObject);
var
  LStatus : String;
  //LHash : String;
begin
  if trim(edtNome.Text) = '' then
  begin
    edtNome.SetFocus;
    Application.MessageBox('O campo NOME n�o pode ser vazio', 'Aten��o', MB_OK + MB_ICONWARNING);
    Abort;
  end;

  if trim(edtLogin.Text) = '' then
  begin
    edtLogin.SetFocus;
    Application.MessageBox('O campo LOGIN n�o pode ser vazio', 'Aten��o', MB_OK + MB_ICONWARNING);
    Abort;
  end;

  {if trim(edtSenha.Text) = '' then
  begin
    edtSenha.SetFocus;
    Application.MessageBox('O campo SENHA n�o pode ser vazio', 'Aten��o', MB_OK + MB_ICONWARNING);
    Abort;
  end;}

  if dmUsuarios.TemLoginCadastrado(Trim(edtLogin.Text), dmUsuarios.cdsUsuarios.FieldByName('ID').AsString) then
  begin
    edtLogin.SetFocus;
    Application.MessageBox(PWideChar(Format('O Login %s j� se encontra cadastrado.', [edtLogin.Text])), 'Aten��o', MB_OK + MB_ICONWARNING);
    Abort;
  end;


  {if Length(edtSenha.Text) < 4  then
  begin
    Application.MessageBox('A senha deve conter no minimo 4 caracteres', 'Alerta', MB_OK + MB_ICONEXCLAMATION);
    Abort;
  end;           }


  LStatus := 'A';

  if ToggleStatus.State = tssOff then
    LStatus := 'B';


  if dmUsuarios.cdsUsuarios.State in [dsInsert] then
  begin
    dmUsuarios.cdsUsuariosID.AsString := TUtilitarios.GetID;
    dmUsuarios.cdsUsuariosDataCadastro.AsDateTime := now;
    dmUsuarios.cdsUsuariosSenha.AsString := TBCrypt.GenerateHash(dmUsuarios.TEMP_PASSWORD);
    dmUsuarios.cdsUsuariossenha_temporaria.AsString := 'S';
  end;

  //LHash := TBCrypt.GenerateHash(Trim(edtSenha.Text));

  dmUsuarios.cdsUsuariosNome.AsString := Trim(edtNome.Text);
  dmUsuarios.cdsUsuariosLogin.AsString := Trim(edtLogin.Text);
  //dmUsuarios.cdsUsuariosSenha.AsString := LHash;                           //Trim(edtSenha.Text);
  dmUsuarios.cdsUsuariosStatus.AsString := LStatus; 


  inherited;
end;

function TformUsuarios.LimparString(const Astr: String): String;
begin
  Result := StringReplace(AStr, '''', '''''', [rfReplaceAll]);
end;

procedure TformUsuarios.mnuLimparSenhaClick(Sender: TObject);
begin
  inherited;
  if not DataSource1.DataSet.IsEmpty then
  begin
    dmUsuarios.LimparSenha(DataSource1.DataSet.FieldByName('ID').AsString);
    Application.MessageBox(PWidechar(Format('Foi definida a senha padr�o para o usu�rio "%s" ', [ DataSource1.DataSet.FieldByName('NOME').AsString])), 'Sucesso', MB_OK + MB_ICONINFORMATION);
  end;

end;

procedure TformUsuarios.Pesquisar;
var
  FiltroPesquisa : String;
begin
  inherited;
  FiltroPesquisa := TUtilitarios.LikeFind(LimparString(edtPesquisar.Text), DBGrid1);
  dmUsuarios.cdsUsuarios.Close;
  dmUsuarios.cdsUsuarios.CommandText := 'select * from usuarios' + FiltroPesquisa;
  dmUsuarios.cdsUsuarios.Open;
end;

end.
