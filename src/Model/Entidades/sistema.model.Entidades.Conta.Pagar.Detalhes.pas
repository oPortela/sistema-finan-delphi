unit sistema.model.Entidades.Conta.Pagar.Detalhes;

interface
type
  TModelContaPagarDetalhe = class
    private
      FValor: Currency;
      FDetalhes: String;
      FID: String;
      FUsuario: String;
      FIdContaPagar: String;
      FData: Tdate;
      procedure SetDetalhes(const Value: String);
      procedure SetID(const Value: String);
      procedure SetUsuario(const Value: String);
      procedure SetValor(const Value: Currency);
      procedure SetData(const Value: Tdate);
      procedure SetIdContaPagar(const Value: String);
    public
      property ID : String read FID write SetID;
      property IdContaPagar : String read FIdContaPagar write SetIdContaPagar;
      property Detalhes : String read FDetalhes write SetDetalhes;
      property Valor : Currency read FValor write SetValor;
      property Data : Tdate read FData write SetData;
      property Usuario : String read FUsuario write SetUsuario;
  end;

implementation

{ TModelContaPagarDetalhe }

procedure TModelContaPagarDetalhe.SetData(const Value: Tdate);
begin
  FData := Value;
end;

procedure TModelContaPagarDetalhe.SetDetalhes(const Value: String);
begin
  FDetalhes := Value;
end;

procedure TModelContaPagarDetalhe.SetID(const Value: String);
begin
  FID := Value;
end;

procedure TModelContaPagarDetalhe.SetIdContaPagar(const Value: String);
begin
  FIdContaPagar := Value;
end;

procedure TModelContaPagarDetalhe.SetUsuario(const Value: String);
begin
  FUsuario := Value;
end;

procedure TModelContaPagarDetalhe.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

end.
