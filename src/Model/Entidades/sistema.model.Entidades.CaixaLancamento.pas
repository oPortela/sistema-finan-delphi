unit sistema.model.Entidades.CaixaLancamento;

interface
type
  TModelCaixaLancamento = class
    private
    FID: String;
    FValor: Currency;
    FNumeroDoc: String;
    FDescricao: String;
    FDataCadastro: TDate;
    FTipo: String;
    procedure SetID(const Value: String);
    procedure SetDescricao(const Value: String);
    procedure SetNumeroDoc(const Value: String);
    procedure SetValor(const Value: Currency);
    procedure SetDataCadastro(const Value: TDate);
    procedure SetTipo(const Value: String);
    public
      property ID : String read FID write SetID;
      property NumeroDoc : String read FNumeroDoc write SetNumeroDoc;
      property Descricao : String read FDescricao write SetDescricao;
      property Valor : Currency read FValor write SetValor;
      property Tipo : String read FTipo write SetTipo;
      property DataCadastro : TDate read FDataCadastro write SetDataCadastro;
  end;

implementation

{ TModelCaixaLancamento }

procedure TModelCaixaLancamento.SetDataCadastro(const Value: TDate);
begin
  FDataCadastro := Value;
end;

procedure TModelCaixaLancamento.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TModelCaixaLancamento.SetID(const Value: String);
begin
  FID := Value;
end;

procedure TModelCaixaLancamento.SetNumeroDoc(const Value: String);
begin
  FNumeroDoc := Value;
end;

procedure TModelCaixaLancamento.SetTipo(const Value: String);
begin
  FTipo := Value;
end;

procedure TModelCaixaLancamento.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

end.
