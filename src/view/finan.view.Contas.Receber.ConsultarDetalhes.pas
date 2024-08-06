unit finan.view.Contas.Receber.ConsultarDetalhes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, System.ImageList, Vcl.ImgList, Vcl.StdCtrls, sistema.model.Contas.Receber;

type
  TfrmConsultarDetalhes = class(TForm)
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
    lblValorVenda: TLabel;
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
    procedure exibirContasReceberDetalhes(IDContaReceber : String);
  end;

var
  frmConsultarDetalhes: TfrmConsultarDetalhes;

implementation

uses
  sistema.model.Entidades.Conta.Receber, finan.Utilitarios;

{$R *.dfm}

procedure TfrmConsultarDetalhes.btnFecharClick(Sender: TObject);
begin
  ModalResult := MrOK;
end;

procedure TfrmConsultarDetalhes.exibirContasReceberDetalhes(IDContaReceber: String);
var
  ContaReceber : TModelContaReceber;
  SQL : String;
begin
  if IDContaReceber.IsEmpty then
    raise Exception.Create('ID do contas a receber inv�lido!');

  ContaReceber := dmContasReceber.GetContaReceber(IDContaReceber);

  try
    if ContaReceber.ID.IsEmpty then
      raise Exception.Create('Contas a receber n�o encontrado!');

    lblNumeroDocumento.Caption := ContaReceber.Documento;
    lblDescricao.Caption := ContaReceber.Descricao;
    lblVencimento.Caption := FormatDateTime('DD/MM/YYYY', ContaReceber.DataVencimento);
    lblNumeroParcela.Caption := ContaReceber.Parcela.ToString;
    lblValorVenda.Caption := tutilitarios.FormatoMoeda(ContaReceber.ValorVenda);
    lblValorParcela.Caption := tutilitarios.FormatoMoeda(ContaReceber.ValorParcela);
  finally
    ContaReceber.Free;
  end;

  SQL := 'SELECT * FROM CONTAS_RECEBER_DETALHES' +
         ' LEFT JOIN USUARIOS ON CONTAS_RECEBER_DETALHES.USUARIO = USUARIOS.ID ' +
         ' WHERE ID_CONTA_RECEBER = :IDCONTARECEBER';
  dmContasReceber.sqlReceberDetalhes.Close;
  dmContasReceber.sqlReceberDetalhes.SQL.Clear;
  dmContasReceber.sqlReceberDetalhes.Params.Clear;
  dmContasReceber.sqlReceberDetalhes.SQL.Add(SQL);
  dmContasReceber.sqlReceberDetalhes.ParamByName('IDCONTARECEBER').AsString := IDContaReceber;
  dmContasReceber.sqlReceberDetalhes.Prepare;
  dmContasReceber.sqlReceberDetalhes.Open;

  lblQtdRegistros.Caption := Format('Quantidade de Registros: %d', [DataSource1.DataSet.RecordCount]);
  lblTotalDetalhes.Caption := 'Total de Recebimentos: R$ ' + TUtilitarios.FormatarValor(dmContasReceber.sqlReceberDetalhes.FieldByName('TOTAL').AsString);

  Self.ShowModal;
end;

end.
