unit finan.view.Contas.Pagar.ConsultarDetalhes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, System.ImageList, Vcl.ImgList, Vcl.StdCtrls, sistema.model.Contas.Pagar;

type
  TfrmConsultarPagarDetalhes = class(TForm)
    Panel1: TPanel;
    pnlBottom: TPanel;
    pnlGrid: TPanel;
    pnlCabecalho: TPanel;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ImageList1: TImageList;
    btnFechar: TButton;
    panel: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    label10: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lblNumeroDocumento: TLabel;
    lblVencimento: TLabel;
    lblNumeroParcela: TLabel;
    Panel6: TPanel;
    lblDescricao: TLabel;
    lblValorCompra: TLabel;
    lblValorParcela: TLabel;
    Panel7: TPanel;
    Label6: TLabel;
    label20: TLabel;
    Label8: TLabel;
    Panel2: TPanel;
    lblQtdRegistros: TLabel;
    lblTotalDetalhes: TLabel;
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure exibirContasPagarDetalhes(IDContaPagar : String);
  end;

var
  frmConsultarPagarDetalhes: TfrmConsultarPagarDetalhes;

implementation

uses
  sistema.model.Entidades.Conta.Pagar, finan.Utilitarios;

{$R *.dfm}

procedure TfrmConsultarPagarDetalhes.btnFecharClick(Sender: TObject);
begin
  ModalResult := MrOK;
end;

procedure TfrmConsultarPagarDetalhes.exibirContasPagarDetalhes(IDContaPagar: String);
var
  ContaPagar : TModelContaPagar;
  SQL : String;
begin
  if IDContaPagar.IsEmpty then
    raise Exception.Create('ID do contas a pagar inv�lido!');

  ContaPagar := dmContasPagar.GetContaPagar(IDContaPagar);

  try
    if ContaPagar.ID.IsEmpty then
      raise Exception.Create('Contas a pagar n�o encontrado!');

    lblNumeroDocumento.Caption := ContaPagar.Documento;
    lblDescricao.Caption := ContaPagar.Descricao;
    lblVencimento.Caption := FormatDateTime('DD/MM/YYYY', ContaPagar.DataVencimento);
    lblNumeroParcela.Caption := ContaPagar.Parcela.ToString;
    lblValorCompra.Caption := tutilitarios.FormatoMoeda(ContaPagar.ValorCompra);
    lblValorParcela.Caption := tutilitarios.FormatoMoeda(ContaPagar.ValorParcela);
  finally
    ContaPagar.Free;
  end;

  SQL := 'SELECT * FROM CONTAS_PAGAR_DETALHES' +
         ' LEFT JOIN USUARIOS ON CONTAS_PAGAR_DETALHES.USUARIO = USUARIOS.ID ' +
         ' WHERE ID_CONTAS_PAGAR = :IDCONTAPAGAR';
  dmContasPagar.sqlPagarDetalhes.Close;
  dmContasPagar.sqlPagarDetalhes.SQL.Clear;
  dmContasPagar.sqlPagarDetalhes.Params.Clear;
  dmContasPagar.sqlPagarDetalhes.SQL.Add(SQL);
  dmContasPagar.sqlPagarDetalhes.ParamByName('IDCONTAPAGAR').AsString := IDContaPagar;
  dmContasPagar.sqlPagarDetalhes.Prepare;
  dmContasPagar.sqlPagarDetalhes.Open;

  lblQtdRegistros.Caption := Format('Quantidade de Registros: %d', [DataSource1.DataSet.RecordCount]);
  lblTotalDetalhes.Caption := 'Total de Recebimentos: R$ ' + TUtilitarios.FormatarValor(dmContasPagar.sqlPagarDetalhes.FieldByName('TOTAL').AsString);

  Self.ShowModal;
end;

end.
