unit sistema.model.Entidades.Conta.Pagar;

interface
type
  TModelContaPagar = class
    private
      FID: String;
      FValorParcela: Currency;
      FDataCompra: TDate;
      FDescricao: String;
      FDataVencimento: Tdate;
      FDataPagamento: Tdate;
      FDocumento: String;
      FValorAbatido: Currency;
      FValorCompra: Currency;
      FStatus: String;
      FDataCadastro: Tdate;
      FParcela: Integer;
      procedure SetID(const Value: String);
      procedure SetDataCadastro(const Value: Tdate);
      procedure SetDataCompra(const Value: TDate);
      procedure SetDataPagamento(const Value: Tdate);
      procedure SetDataVencimento(const Value: Tdate);
      procedure SetDescricao(const Value: String);
      procedure SetDocumento(const Value: String);
      procedure SetParcela(const Value: Integer);
      procedure SetStatus(const Value: String);
      procedure SetValorAbatido(const Value: Currency);
      procedure SetValorCompra(const Value: Currency);
      procedure SetValorParcela(const Value: Currency);
    public
      property ID : String read FID write SetID;
      property Documento : String read FDocumento write SetDocumento;
      property Descricao : String read FDescricao write SetDescricao;
      property Parcela : Integer read FParcela write SetParcela;
      property ValorParcela : Currency read FValorParcela write SetValorParcela;
      property ValorCompra : Currency read FValorCompra write SetValorCompra;
      property ValorAbatido : Currency read FValorAbatido write SetValorAbatido;
      property DataCompra : TDate read FDataCompra write SetDataCompra;
      property DataCadastro : Tdate read FDataCadastro write SetDataCadastro;
      property DataVencimento : Tdate read FDataVencimento write SetDataVencimento;
      property DataPagamento : Tdate read FDataPagamento write SetDataPagamento;
      property Status : String read FStatus write SetStatus;
  end;

implementation

{ TModelContaPagar }

procedure TModelContaPagar.SetDataCadastro(const Value: Tdate);
begin
  FDataCadastro := Value;
end;

procedure TModelContaPagar.SetDataCompra(const Value: TDate);
begin
  FDataCompra := Value;
end;

procedure TModelContaPagar.SetDataPagamento(const Value: Tdate);
begin
  FDataPagamento := Value;
end;

procedure TModelContaPagar.SetDataVencimento(const Value: Tdate);
begin
  FDataVencimento := Value;
end;

procedure TModelContaPagar.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TModelContaPagar.SetDocumento(const Value: String);
begin
  FDocumento := Value;
end;

procedure TModelContaPagar.SetID(const Value: String);
begin
  FID := Value;
end;

procedure TModelContaPagar.SetParcela(const Value: Integer);
begin
  FParcela := Value;
end;

procedure TModelContaPagar.SetStatus(const Value: String);
begin
  FStatus := Value;
end;

procedure TModelContaPagar.SetValorAbatido(const Value: Currency);
begin
  FValorAbatido := Value;
end;

procedure TModelContaPagar.SetValorCompra(const Value: Currency);
begin
  FValorCompra := Value;
end;

procedure TModelContaPagar.SetValorParcela(const Value: Currency);
begin
  FValorParcela := Value;
end;

end.
