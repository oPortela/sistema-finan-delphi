unit sistema.model.Entidades.Conta.Receber.Detalhes;

interface
type
  TModelContaReceberDetalhes = class
    private
    FValor: Currency;
    FIdContaReceber: String;
    FDetalhes: String;
    FID: String;
    FUsuario: String;
    FData: TDateTime;
    procedure SetData(const Value: TDateTime);
    procedure SetDetalhes(const Value: String);
    procedure SetID(const Value: String);
    procedure SetIdContaReceber(const Value: String);
    procedure SetUsuario(const Value: String);
    procedure SetValor(const Value: Currency);
    public
      property ID : String read FID write SetID;
      property IdContaReceber : String read FIdContaReceber write SetIdContaReceber;
      property Detalhes : String read FDetalhes write SetDetalhes;
      property Valor : Currency read FValor write SetValor;
      property Data : TDateTime read FData write SetData;
      property Usuario : String read FUsuario write SetUsuario;
  end;

implementation

{ TModelContaReceberDetalhes }

procedure TModelContaReceberDetalhes.SetData(const Value: TDateTime);
begin
  FData := Value;
end;

procedure TModelContaReceberDetalhes.SetDetalhes(const Value: String);
begin
  FDetalhes := Value;
end;

procedure TModelContaReceberDetalhes.SetID(const Value: String);
begin
  FID := Value;
end;

procedure TModelContaReceberDetalhes.SetIdContaReceber(const Value: String);
begin
  FIdContaReceber := Value;
end;

procedure TModelContaReceberDetalhes.SetUsuario(const Value: String);
begin
  FUsuario := Value;
end;

procedure TModelContaReceberDetalhes.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

end.
