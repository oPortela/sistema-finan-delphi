unit sistema.model.usuarios;

interface

uses
  System.SysUtils, System.Classes, Data.FMTBcd, Datasnap.Provider,
  Datasnap.DBClient, Data.DB, Data.SqlExpr, sistema.model.conexao,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  sistema.model.Entidades.usuarios;

type
  TdmUsuarios = class(TDataModule)
    cdsUsuarios: TClientDataSet;
    dspUsuarios: TDataSetProvider;
    sqlUsuarios: TFDQuery;
    cdsUsuariosID: TStringField;
    cdsUsuariosNome: TStringField;
    cdsUsuariosLogin: TStringField;
    cdsUsuariosSenha: TStringField;
    cdsUsuariosStatus: TStringField;
    cdsUsuariosDataCadastro: TDateField;
    cdsUsuariossenha_temporaria: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FentidadeUsuario : TModelEntidadeUsuario;
    { Private declarations }
  public
    { Public declarations }
    function TemLoginCadastrado(Login : String; ID : String) : Boolean;
    procedure efetuarLogin(Login : String; Senha : String);
    function GetUsuarioLogado : TModelEntidadeUsuario;
    procedure LimparSenha(IDusuario : String);
    procedure RedefinirSenha(Usuario : TModelEntidadeUsuario);
    const TEMP_PASSWORD = '123456';
  end;

var
  dmUsuarios: TdmUsuarios;

implementation

uses
  BCrypt;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


{ TdmUsuarios }

procedure TdmUsuarios.DataModuleCreate(Sender: TObject);
begin
  FentidadeUsuario := TModelEntidadeUsuario.Create;
end;

procedure TdmUsuarios.DataModuleDestroy(Sender: TObject);
begin
  FentidadeUsuario.Free;
end;

procedure TdmUsuarios.efetuarLogin(Login, Senha: String);
var
  SQLConsulta : TFDQuery;
begin
  SQLConsulta := TFDQuery.Create(nil);
  try
    SQLConsulta.Connection := dmConexao.SQLConexao;
    SQLConsulta.SQL.Clear;
    SQLConsulta.SQL.Add('SELECT * FROM USUARIOS WHERE LOGIN = :LOGIN');        //passando um parametro
    SQLConsulta.ParamByName('LOGIN').AsString := Login;                                      //setando o parametro
    SQLConsulta.Open;

    if SQLConsulta.IsEmpty then
      raise Exception.Create('Usu�rio e/ou senha inv�lido!');

    if not TBCrypt.CompareHash(senha, SQLConsulta.FieldByName('SENHA').AsString) then
      raise Exception.Create('Usu�rio e/ou senha inv�lido!Usu�rio e/ou senha inv�lido!');

    if SQLConsulta.FieldByName('STATUS').AsString <> 'A' then
      raise Exception.Create('Usu�rio Bloqueado, favor entrar em contato com o administrador.');

    FentidadeUsuario.ID := SQLConsulta.FieldByName('ID').AsString;
    FentidadeUsuario.Nome := SQLConsulta.FieldByName('NOME').AsString;
    FentidadeUsuario.Login := SQLConsulta.FieldByName('LOGIN').AsString;
    FentidadeUsuario.Senha := SQLConsulta.FieldByName('SENHA').AsString;
    FentidadeUsuario.SenhaTemporaria := SQLConsulta.FieldByName('SENHA_TEMPORARIA').AsString = 'S';
  finally
    SQLConsulta.Close;
    SQLConsulta.Free;
  end;
end;

function TdmUsuarios.GetUsuarioLogado: TModelEntidadeUsuario;
begin
  Result := FentidadeUsuario;
end;

procedure TdmUsuarios.LimparSenha(IDusuario: String);
var
  SQLQuery : TFDQuery;
begin
  SQLQuery :=TFDQuery.Create(nil);
  try
    SQLQuery.Connection := dmConexao.SQLConexao;
    SQLQuery.SQL.Clear;
    SQLQuery.SQL.Add('UPDATE USUARIOS SET SENHA_TEMPORARIA = :SENHA_TEMPORARIA, SENHA = :SENHA WHERE ID = :ID');        //passando um parametro
    SQLQuery.ParamByName('SENHA_TEMPORARIA').AsString := 'S';
    SQLQuery.ParamByName('SENHA').AsString := TBCrypt.GenerateHash(TEMP_PASSWORD);
    SQLQuery.ParamByName('ID').AsString := IDusuario;
    SQLQuery.ExecSQL;
  finally
    SQLQuery.Close;
    SQLQuery.Free;
  end;
end;

procedure TdmUsuarios.RedefinirSenha(Usuario: TModelEntidadeUsuario);
var
  SQLQuery : TFDQuery;
begin
  SQLQuery :=TFDQuery.Create(nil);
  try
    SQLQuery.Connection := dmConexao.SQLConexao;
    SQLQuery.SQL.Clear;
    SQLQuery.SQL.Add('UPDATE USUARIOS SET SENHA_TEMPORARIA = :SENHA_TEMPORARIA, SENHA = :SENHA WHERE ID = :ID');        //passando um parametro
    SQLQuery.ParamByName('SENHA_TEMPORARIA').AsString := 'N';
    SQLQuery.ParamByName('SENHA').AsString := TBCrypt.GenerateHash(Usuario.Senha);
    SQLQuery.ParamByName('ID').AsString := Usuario.ID;
    SQLQuery.ExecSQL;
  finally
    SQLQuery.Close;
    SQLQuery.Free;
  end;
end;

function TdmUsuarios.TemLoginCadastrado(Login, ID: String): Boolean;
var
  SQLConsulta : TFDQuery;
begin
  Result := False;
  SQLConsulta := TFDQuery.Create(nil);
  try
    SQLConsulta.Connection := dmConexao.SQLConexao;
    SQLConsulta.SQL.Clear;
    SQLConsulta.SQL.Add('SELECT ID FROM USUARIOS WHERE LOGIN = :LOGIN');        //passando um parametro
    SQLConsulta.ParamByName('LOGIN').AsString := Login;                         //setando o parametro
    SQLConsulta.Open;
    if not SQLConsulta.IsEmpty then
      Result := SQLConsulta.FieldByName('ID').AsString <> ID;
  finally
    SQLConsulta.Close;
    SQLConsulta.Free;
  end;
end;

end.
