unit sistema.model.Entidades.usuarios;

interface
type
  TModelEntidadeUsuario = class
  private
    FLogin: String;
    FNome: String;
    FID: String;
    FSenha: String;
    FSenhaTemporaria: Boolean;
    procedure SetID(const Value: String);
    procedure SetLogin(const Value: String);
    procedure SetNome(const Value: String);
    procedure SetSenha(const Value: String);
    procedure SetSenhaTemporaria(const Value: Boolean);
  public
    property Nome : String read FNome write SetNome;
    property Login : String read FLogin write SetLogin;
    property ID : String read FID write SetID;
    property Senha : String read FSenha write SetSenha;
    property SenhaTemporaria : Boolean read FSenhaTemporaria write SetSenhaTemporaria;
  end;

implementation

{ TModelEntidadeUsuario }

procedure TModelEntidadeUsuario.SetID(const Value: String);
begin
  FID := Value;
end;

procedure TModelEntidadeUsuario.SetLogin(const Value: String);
begin
  FLogin := Value;
end;

procedure TModelEntidadeUsuario.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TModelEntidadeUsuario.SetSenha(const Value: String);
begin
  FSenha := Value;
end;

procedure TModelEntidadeUsuario.SetSenhaTemporaria(const Value: Boolean);
begin
  FSenhaTemporaria := Value;
end;

end.
