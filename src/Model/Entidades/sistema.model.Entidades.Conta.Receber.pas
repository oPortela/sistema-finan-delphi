unit sistema.model.Entidades.Conta.Receber;

interface
type
  TModelContaReceber = class
    private
    FDataVenda: TDate;
    FValorParcela: Currency;
    FValorVenda: Currency;
    FDescricao: String;
    FDataVencimento: Tdate;
    FDocumento: String;
    FID: String;
    FValorAbatido: Currency;
    FStatus: String;
    FDataCadastro: Tdate;
    FParcela: Integer;
    FDataRecebimento: Tdate;
    procedure SetDataCadastro(const Value: Tdate);
    procedure SetDataVencimento(const Value: Tdate);
    procedure SetDataVenda(const Value: TDate);
    procedure SetDescricao(const Value: String);
    procedure SetDocumento(const Value: String);
    procedure SetID(const Value: String);
    procedure SetParcela(const Value: Integer);
    procedure SetStatus(const Value: String);
    procedure SetValorAbatido(const Value: Currency);
    procedure SetValorParcela(const Value: Currency);
    procedure SetValorVenda(const Value: Currency);
    procedure SetDataRecebimento(const Value: Tdate);
    public
      property ID : String read FID write SetID;
      property Documento : String read FDocumento write SetDocumento;
      property Descricao : String read FDescricao write SetDescricao;
      property Parcela : Integer read FParcela write SetParcela;
      property ValorParcela : Currency read FValorParcela write SetValorParcela;
      property ValorVenda : Currency read FValorVenda write SetValorVenda;
      property ValorAbatido : Currency read FValorAbatido write SetValorAbatido;
      property DataVenda : TDate read FDataVenda write SetDataVenda;
      property DataCadastro : Tdate read FDataCadastro write SetDataCadastro;
      property DataVencimento : Tdate read FDataVencimento write SetDataVencimento;
      property DataRecebimento : Tdate read FDataRecebimento write SetDataRecebimento;
      property Status : String read FStatus write SetStatus;
  end;

implementation

{ TModelContaReceber }

procedure TModelContaReceber.SetDataCadastro(const Value: Tdate);
begin
  FDataCadastro := Value;
end;

procedure TModelContaReceber.SetDataRecebimento(const Value: Tdate);
begin
  FDataRecebimento := Value;
end;

procedure TModelContaReceber.SetDataVencimento(const Value: Tdate);
begin
  FDataVencimento := Value;
end;

procedure TModelContaReceber.SetDataVenda(const Value: TDate);
begin
  FDataVenda := Value;
end;

procedure TModelContaReceber.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TModelContaReceber.SetDocumento(const Value: String);
begin
  FDocumento := Value;
end;

procedure TModelContaReceber.SetID(const Value: String);
begin
  FID := Value;
end;

procedure TModelContaReceber.SetParcela(const Value: Integer);
begin
  FParcela := Value;
end;

procedure TModelContaReceber.SetStatus(const Value: String);
begin
  FStatus := Value;
end;

procedure TModelContaReceber.SetValorAbatido(const Value: Currency);
begin
  FValorAbatido := Value;
end;

procedure TModelContaReceber.SetValorParcela(const Value: Currency);
begin
  FValorParcela := Value;
end;

procedure TModelContaReceber.SetValorVenda(const Value: Currency);
begin
  FValorVenda := Value;
end;

end.
