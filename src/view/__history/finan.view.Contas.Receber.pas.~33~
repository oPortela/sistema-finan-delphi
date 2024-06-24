unit finan.view.Contas.Receber;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, finan.view.cadastroPadrao, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.WinXPanels, sistema.model.Contas.Receber, Datasnap.DBClient,
  Vcl.WinXCtrls, Vcl.ComCtrls, Vcl.Menus;

type
  TfrmContasReceber = class(TformCadastroPadrao)
    cdsParcelas: TClientDataSet;
    cdsParcelasParcela: TIntegerField;
    cdsParcelasDocumento: TStringField;
    cdsParcelasValor: TCurrencyField;
    cdsParcelasVencimento: TDateField;
    dsParcelas: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    edtDescricao: TEdit;
    edtValorVenda: TEdit;
    dateVenda: TDateTimePicker;
    toggleParcelamento: TToggleSwitch;
    cardParcela: TCardPanel;
    cardParcelaUnica: TCard;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edtNumeroDocumento: TEdit;
    edtParcela: TEdit;
    edtValorParcela: TEdit;
    dateVencimento: TDateTimePicker;
    cardParcelamento: TCard;
    Label10: TLabel;
    Label11: TLabel;
    edtParcelas: TEdit;
    edtIntervaloDias: TEdit;
    btnLimpar: TButton;
    btnGerar: TButton;
    DBGrid2: TDBGrid;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure toggleParcelamentoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtValorVendaExit(Sender: TObject);
    procedure edtValorParcelaExit(Sender: TObject);

  private
    { Private declarations }
    procedure cadastrarParcelas;
    procedure cadastrarParcelaUnica;
  public
    { Public declarations }
  protected
    procedure Pesquisar; override;
  end;

var
  frmContasReceber: TfrmContasReceber;

implementation

uses
  finan.Utilitarios, System.DateUtils, finan.view.Contas.Pagar.Baixar;

{$R *.dfm}


{ TfrmContasReceber }

procedure TfrmContasReceber.btnAlterarClick(Sender: TObject);
begin
if dmContasReceber.cdsContasReceberstatus.AsString = 'B' then
  begin
    Application.MessageBox('O documento já foi baixado e não pode ser alterado!', 'Atenção!', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if dmContasReceber.cdsContasReceberStatus.AsString = 'C' then
  begin
    Application.MessageBox('O documento já foi cancelado e não pode ser alterado!', 'Atenção!', MB_OK + MB_ICONWARNING);
    abort;
  end;

  inherited;

  toggleParcelamento.Enabled := False;
  toggleParcelamento.State := tssOff;
  cardParcela.ActiveCard := cardParcelaUnica;
  cdsParcelas.EmptyDataSet;

  edtNumeroDocumento.Text := dmContasReceber.cdsContasRecebernumero_documento.AsString;
  edtDescricao.Text := dmContasReceber.cdsContasReceberdescricao.AsString;
  edtValorVenda.Text := TUtilitarios.FormatarValor(dmContasReceber.cdsContasRecebervalor_venda.AsCurrency);
  dateVenda.DateTime := dmContasReceber.cdsContasReceberdata_venda.AsDateTime;
  edtParcela.Text := dmContasReceber.cdsContasReceberparcela.AsString;
  edtValorParcela.Text := TUtilitarios.FormatarValor(dmContasReceber.cdsContasRecebervalor_parcela.AsCurrency);
  dateVencimento.DateTime := dmContasReceber.cdsContasReceberdata_vencimento.AsDateTime;

end;

procedure TfrmContasReceber.btnExcluirClick(Sender: TObject);
begin
if dmContasReceber.cdsContasReceberstatus.AsString = 'C' then
  begin
    Application.MessageBox('O documento já se encontra cancelado!', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if Application.MessageBox('Deseja realmente cancelar este documento?', 'Cancelamento', MB_YESNO + MB_ICONQUESTION) <> mrYes then
    exit;

  try
    dmContasReceber.cdsContasReceber.Edit;
    dmContasReceber.cdsContasReceberstatus.AsString := 'C';
    dmContasReceber.cdsContasReceber.Post;
    dmContasReceber.cdsContasReceber.ApplyUpdates(0);
    Application.MessageBox('Resgistro cancelado com sucesso!', 'Cancelado', MB_OK + MB_ICONINFORMATION);
    Pesquisar;
  except
    on E: Exception do
      Application.MessageBox(PWideChar(E.Message), 'Erro ao cancelar o documento!', MB_OK + MB_ICONERROR);
  end;

end;

procedure TfrmContasReceber.btnGerarClick(Sender: TObject);
var
  QuantidadeParcelas : Integer;
  IntervaloDias : Integer;
  ValorVenda : Currency;
  ValorParcela : Currency;
  ValorResiduo : Currency;
  Contador: Integer;
begin
  if not TryStrToCurr(edtValorVenda.Text, ValorVenda) then
  begin
    edtValorVenda.SetFocus;
    Application.MessageBox('Valor da compra inválido!', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if not TryStrToInt(edtParcelas.Text, QuantidadeParcelas) then
  begin
    edtParcelas.SetFocus;
    Application.MessageBox('Quantidade de parcelas inválido!', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if not TryStrToInt(edtIntervaloDias.Text, IntervaloDias) then
  begin
    edtIntervaloDias.SetFocus;
    Application.MessageBox('Intervalo inválido!', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  ValorParcela := TUtilitarios.TruncarValor(ValorVenda / QuantidadeParcelas);      // Trunc((ValorVenda / QuantidadeParcelas) * 100) / 100;
  ValorResiduo := ValorVenda - (ValorParcela * QuantidadeParcelas);

  cdsParcelas.EmptyDataSet;

  for Contador := 1 to QuantidadeParcelas do
  begin
    cdsParcelas.Insert;
    cdsParcelasParcela.AsInteger := Contador;
    cdsParcelasValor.AsCurrency := ValorParcela + ValorResiduo;
    ValorResiduo := 0;
    cdsParcelasVencimento.AsDateTime := Incday(dateVenda.Date, IntervaloDias * Contador);
    cdsParcelas.Post;
  end;

end;

procedure TfrmContasReceber.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dateVenda.Date := Now;
  dateVencimento.Date := Now;

  toggleParcelamento.Enabled := True;
  toggleParcelamento.State := tssOff;
  cardParcela.ActiveCard := cardParcelaUnica;
  cdsParcelas.EmptyDataSet;

end;

procedure TfrmContasReceber.btnLimparClick(Sender: TObject);
begin
  inherited;
  cdsParcelas.EmptyDataSet;
end;

procedure TfrmContasReceber.btnSalvarClick(Sender: TObject);
begin
  if toggleParcelamento.State = tssOff then
  begin
    cadastrarParcelaUnica;
    inherited;
  end
  else
    cadastrarParcelas;
end;

procedure TfrmContasReceber.cadastrarParcelas;
var
  ValorVenda : Currency;
begin
  if not tryStrToCurr(edtValorVenda.Text, ValorVenda) then
  begin
    edtValorVenda.SetFocus;
    Application.MessageBox('Valor da venda inválido!', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  cdsParcelas.First;
  while not cdsParcelas.Eof do
  begin
    if cdsParcelasParcela.AsInteger < 0 then
    begin
      Application.MessageBox('O número de parcelas inválido!', 'Atenção', MB_OK + MB_ICONWARNING);
      abort;
    end;

    if cdsParcelasDocumento.AsString = '' then
    begin
      Application.MessageBox('Número do documento inválido!', 'Atenção', MB_OK + MB_ICONWARNING);
      abort;
    end;

    if cdsParcelasValor.AsCurrency < 0.01 then
    begin
      Application.MessageBox('Valor da parcela inválido!', 'Atenção', MB_OK + MB_ICONWARNING);
      abort;
    end;

    cdsParcelas.Next;
  end;

  cdsParcelas.First;
  while not cdsParcelas.Eof do
  begin
    if dmContasReceber.cdsContasReceber.State in [dsBrowse, dsInactive] then
      dmContasReceber.cdsContasReceber.Insert;

    dmContasReceber.cdsContasReceberid.AsString := TUtilitarios.GetId;
    dmContasReceber.cdsContasReceberdata_cadastro.AsDateTime := now;
    dmContasReceber.cdsContasReceberstatus.AsString := 'A';
    dmContasReceber.cdsContasRecebervalor_abatido.AsCurrency := 0;

    dmContasReceber.cdsContasReceberdata_venda.AsDateTime := dateVenda.Date;
    dmContasReceber.cdsContasRecebernumero_documento.AsString := cdsParcelasDocumento.AsString;
    dmContasReceber.cdsContasReceberdescricao.AsString := Format('%s - Parcela %d', [edtDescricao.Text, cdsParcelasParcela.AsInteger]);
    dmContasReceber.cdsContasRecebervalor_venda.AsCurrency := ValorVenda;
    dmContasReceber.cdsContasReceberparcela.AsInteger := cdsParcelasParcela.AsInteger;
    dmContasReceber.cdsContasRecebervalor_parcela.AsCurrency := cdsParcelasValor.AsCurrency;
    dmContasReceber.cdsContasReceberdata_vencimento.AsDateTime := cdsParcelasVencimento.AsDateTime;

    dmContasReceber.cdsContasReceber.Post;
    dmContasReceber.cdsContasReceber.ApplyUpdates(0);

    cdsParcelas.Next;
  end;

  Application.MessageBox('Parcelas cadastradas com sucesso!', 'Atenção', MB_OK + MB_ICONINFORMATION);
  Pesquisar;
  PnlPrincipal.ActiveCard := cardPesquisa;

end;

procedure TfrmContasReceber.cadastrarParcelaUnica;
var
  Parcela : Integer;
  ValorVenda : Currency;
  ValorParcela : CUrrency;
begin
  if edtNumeroDocumento.Text = '' then
  begin
    edtNumeroDocumento.SetFocus;
    Application.MessageBox('O campo número do documento não pode ser vazio!', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if not tryStrToCurr(edtValorVenda.Text, ValorVenda) then
  begin
    edtValorVenda.SetFocus;
    Application.MessageBox('Valor da compra inválido!', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if not TryStrToInt(edtParcela.Text, Parcela) then
  begin
    edtParcela.SetFocus;
    Application.MessageBox('Número da parcela inválido!', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if not TryStrToCurr(edtValorParcela.Text, ValorParcela) then
  begin
    edtValorParcela.SetFocus;
    Application.MessageBox('Valor da parcela inválido!', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if dateVencimento.Date < dateVenda.date then
  begin
    dateVencimento.SetFocus;
    Application.MessageBox('A data de vencimento não pode ser menor que a data de compra!', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if DataSource1.State in [dsInsert] then
  begin
    dmContasReceber.cdsContasReceberid.AsString := TUtilitarios.GetId;
    dmContasReceber.cdsContasReceberdata_cadastro.AsDateTime := now;
    dmContasReceber.cdsContasReceberstatus.AsString := 'A';
    dmContasReceber.cdsContasRecebervalor_abatido.AsCurrency := 0;
  end;

  dmContasReceber.cdsContasReceberdata_venda.AsDateTime := dateVenda.Date;
  dmContasReceber.cdsContasRecebernumero_documento.AsString := edtNumeroDocumento.Text;
  dmContasReceber.cdsContasReceberdescricao.AsString := edtDescricao.Text;
  dmContasReceber.cdsContasRecebervalor_venda.AsCurrency := ValorVenda;
  dmContasReceber.cdsContasReceberparcela.AsInteger := Parcela;
  dmContasReceber.cdsContasRecebervalor_parcela.AsCurrency := ValorParcela;
  dmContasReceber.cdsContasReceberdata_vencimento.AsDateTime := dateVencimento.DateTime;

end;

procedure TfrmContasReceber.edtValorParcelaExit(Sender: TObject);
begin
  edtValorParcela.Text := TUtilitarios.FormatarValor(edtValorParcela.text);
end;

procedure TfrmContasReceber.edtValorVendaExit(Sender: TObject);
begin
  edtValorVenda.Text := TUtilitarios.FormatarValor(edtValorVenda.Text);
end;

procedure TfrmContasReceber.FormCreate(Sender: TObject);
begin
  inherited;
  edtValorVenda.OnKeyPress := TUtilitarios.KeyPressValor;
  edtValorParcela.OnKeyPress := TUtilitarios.KeyPressValor;
end;

procedure TfrmContasReceber.Pesquisar;
var
  FiltroPesquisa : String;
begin
  FiltroPesquisa := TUtilitarios.LikeFind(edtPesquisar.Text, DBGrid1);
  dmContasReceber.cdsContasReceber.Close;
  dmContasReceber.cdsContasReceber.CommandText := 'select * from contas_receber where 1=1' + FiltroPesquisa;
  dmContasReceber.cdsContasReceber.Open;
  inherited;
end;

procedure TfrmContasReceber.toggleParcelamentoClick(Sender: TObject);
begin
  cardParcela.ActiveCard := cardParcelaUnica;

  if toggleParcelamento.State = tssOn then
    cardParcela.ActiveCard := cardParcelamento;
end;

end.
