unit finan.view.Contas.Pagar.Consultar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.ImageList, Vcl.ImgList, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.WinXPanels,
  Vcl.ComCtrls, Vcl.WinXCtrls, sistema.model.Contas.Pagar;

type
  TfrmConsultarContasPagar = class(TForm)
    Panel1: TPanel;
    pnlPesquisa: TPanel;
    btnPesquisar: TButton;
    ImageList1: TImageList;
    pnlGrid: TPanel;
    DBGrid1: TDBGrid;
    pnlBottom: TPanel;
    btnFechar: TButton;
    btnBaixar: TButton;
    DataSource1: TDataSource;
    pnlFiltrarTipo: TPanel;
    Panel4: TPanel;
    StackPanel1: TStackPanel;
    Label1: TLabel;
    cbFiltroTipoData: TComboBox;
    pnlDataInicio: TPanel;
    StackPanel2: TStackPanel;
    pnlDataFim: TPanel;
    StackPanel3: TStackPanel;
    Label2: TLabel;
    Label3: TLabel;
    DateFiltroDataInicio: TDateTimePicker;
    DateFiltroDataFim: TDateTimePicker;
    SplitView1: TSplitView;
    Panel2: TPanel;
    StackPanel4: TStackPanel;
    Label4: TLabel;
    Panel5: TPanel;
    StackPanel5: TStackPanel;
    Label5: TLabel;
    Panel6: TPanel;
    StackPanel6: TStackPanel;
    Label6: TLabel;
    edtNumeroDocumento: TEdit;
    edtParcela: TEdit;
    cbFiltroStatus: TComboBox;
    pnlFiltrar: TPanel;
    btnFiltrar: TButton;
    Panel3: TPanel;
    lblQtdRegistros: TLabel;
    lblTotalRecebimentos: TLabel;
    btnDetalhes: TButton;
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure cbFiltroTipoDataKeyPress(Sender: TObject; var Key: Char);
    procedure cbFiltroTipoDataSelect(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure cbFiltroStatusKeyPress(Sender: TObject; var Key: Char);
    procedure btnBaixarClick(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure btnDetalhesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FFiltroPesquisa : String;
    procedure LimparFiltro;
    procedure AdicionarFiltro(aValue : String);
    procedure Pesquisar;
    procedure FiltrarData;
    procedure FiltrarNumero;
    procedure FiltrarParcela;
    procedure FiltrarStatus;
    procedure HabilitarDatas(aValue : Boolean);
  public
    { Public declarations }
  end;

var
  frmConsultarContasPagar: TfrmConsultarContasPagar;

implementation

uses
  finan.Utilitarios,
  finan.view.Contas.Pagar.Baixar, System.SysUtils,
  finan.view.Contas.Pagar.ConsultarDetalhes;

{$R *.dfm}

procedure TfrmConsultarContasPagar.AdicionarFiltro(aValue: String);
begin
  FFiltroPesquisa := FFiltroPesquisa + ' ' + aValue;
end;

procedure TfrmConsultarContasPagar.btnBaixarClick(Sender: TObject);
begin
  frmContasPagarBaixar.baixarContaPagar(DataSource1.DataSet.FieldByName('ID').AsString);

  if frmContasPagarBaixar.ModalResult = MROK then
    dmContasPagar.cdsContasPagar.Refresh;
end;

procedure TfrmConsultarContasPagar.btnDetalhesClick(Sender: TObject);
begin
  frmConsultarPagarDetalhes.exibirContasPagarDetalhes(DataSource1.DataSet.FieldByName('ID').AsString);
  frmConsultarPagarDetalhes.ShowModal;
end;

procedure TfrmConsultarContasPagar.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmConsultarContasPagar.btnFiltrarClick(Sender: TObject);
begin
  SplitView1.Opened := not SplitView1.Opened;
end;

procedure TfrmConsultarContasPagar.btnPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmConsultarContasPagar.cbFiltroStatusKeyPress(Sender: TObject;
  var Key: Char);
begin
    if key = #27 then
  begin
    cbFiltroStatus.ItemIndex := -1;
    HabilitarDatas(False);
  end;
end;

procedure TfrmConsultarContasPagar.cbFiltroTipoDataKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #27 then
  begin
    cbFiltroTipoData.ItemIndex := -1;
    HabilitarDatas(False);
  end;

end;

procedure TfrmConsultarContasPagar.cbFiltroTipoDataSelect(Sender: TObject);
begin
  HabilitarDatas(True);
end;

procedure TfrmConsultarContasPagar.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  btnBaixar.Enabled := DataSource1.DataSet.FieldByName('STATUS').AsString = 'A';
end;

procedure TfrmConsultarContasPagar.FiltrarData;
var
  CampoData : String;
begin
  if cbFiltroTipoData.ItemIndex = -1 then
    exit;

  if (DateFiltroDataInicio.Checked = False) and (DateFiltroDataFim.Checked = False) then
  begin
    Application.MessageBox('Uma data precisa ser preenchida', 'Aten��o', MB_OK + MB_ICONWARNING);
    abort;
  end;

  case cbFiltroTipoData.ItemIndex of
    0 : CampoData := 'DATA_COMPRA';
    1 : CampoData := 'DATA_VENCIMENTO';
    2 : CampoData := 'DATA_PAGAMENTO';
  end;

  if DateFiltroDataInicio.Checked then
  begin
    AdicionarFiltro('AND ' + CampoData + ' >= :DATAINICIO');
    dmContasPagar.cdsContasPagar.Params.CreateParam(TFieldType.ftDate, 'DATAINICIO', TParamType.ptInput);
    dmContasPagar.cdsContasPagar.ParamByName('DATAINICIO').AsDate := DateFiltroDataInicio.Date;

  end;

  if DateFiltroDataFim.Checked then
  begin
    AdicionarFiltro('AND ' + CampoData + ' <= :DATAFIM');
    dmContasPagar.cdsContasPagar.Params.CreateParam(TFieldType.ftDate, 'DATAFIM', TParamType.ptInput);
    dmContasPagar.cdsContasPagar.ParamByName('DATAFIM').AsDate := DateFiltroDataFim.Date;
  end;
end;

procedure TfrmConsultarContasPagar.FiltrarNumero;
begin
  if edtNumeroDocumento.Text = '' then
    exit;

  AdicionarFiltro(' AND NUMERO_DOCUMENTO = :NUMERODOCUMENTO');
  dmContasPagar.cdsContasPagar.Params.CreateParam(TFieldType.ftString, 'NUMERODOCUMENTO', TParamType.ptInput);
  dmContasPagar.cdsContasPagar.ParamByName('NUMERODOCUMENTO').AsString := edtNumeroDocumento.Text;
end;

procedure TfrmConsultarContasPagar.FiltrarParcela;
var
  Parcela : Integer;
begin
  if edtParcela.Text = '' then
    exit;

  if not TryStrToInt(edtParcela.Text, Parcela) then
  begin
    Application.MessageBox('N�mero de parcela inv�lido!', 'Aten��o', MB_OK + MB_ICONWARNING);
    abort;
  end;

  AdicionarFiltro(' AND PARCELA = :PARCELA');
  dmContasPagar.cdsContasPagar.Params.CreateParam(TFieldType.ftString, 'PARCELA', TParamType.ptInput);
  dmContasPagar.cdsContasPagar.ParamByName('PARCELA').AsString := edtParcela.Text;
end;

procedure TfrmConsultarContasPagar.FiltrarStatus;
begin
  if cbFiltroStatus.ItemIndex = -1 then
    exit;

  case cbFiltroStatus.ItemIndex of
    0 : AdicionarFiltro(' AND STATUS = ''A''');
    1 : AdicionarFiltro(' AND STATUS = ''B''');
    2 : AdicionarFiltro(' AND STATUS = ''C''');
  end;
end;

procedure TfrmConsultarContasPagar.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmConsultarContasPagar.HabilitarDatas(aValue: Boolean);
begin
  DateFiltroDataInicio.Enabled := aValue;
  DateFiltroDataFim.Enabled := aValue;
end;

procedure TfrmConsultarContasPagar.LimparFiltro;
begin
  FFiltroPesquisa := '';
end;

procedure TfrmConsultarContasPagar.Pesquisar;
var
  FiltroPesquisa : String;
begin
  SplitView1.Opened := false;
  LimparFiltro;
  dmContasPagar.cdsContasPagar.Params.Clear;

  FiltrarData;
  FiltrarNumero;
  FiltrarParcela;
  FiltrarStatus;

  dmContasPagar.cdsContasPagar.Close;
  dmContasPagar.cdsContasPagar.CommandText := 'select * from contas_pagar where 1=1' + FFiltroPesquisa;
  dmContasPagar.cdsContasPagar.Open;

  lblQtdRegistros.Caption := Format('Quantidade de Registros: %d', [DataSource1.DataSet.RecordCount]);
  lblTotalRecebimentos.Caption := 'Total de Recebimentos: R$ ' + TUtilitarios.FormatarValor(dmContasPagar.cdsContasPagar.FieldByName('TOTAL').AsString);
end;

end.
