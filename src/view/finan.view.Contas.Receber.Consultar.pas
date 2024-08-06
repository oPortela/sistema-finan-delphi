unit finan.view.Contas.Receber.Consultar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.ImageList, Vcl.ImgList, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.WinXPanels,
  Vcl.ComCtrls, Vcl.WinXCtrls;

type
  TfrmConsultarContasReceber = class(TForm)
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
  frmConsultarContasReceber: TfrmConsultarContasReceber;

implementation

uses
  finan.Utilitarios, sistema.model.Contas.Receber,
  finan.view.Contas.Receber.Baixar, System.SysUtils,
  finan.view.Contas.Receber.ConsultarDetalhes;

{$R *.dfm}

procedure TfrmConsultarContasReceber.AdicionarFiltro(aValue: String);
begin
  FFiltroPesquisa := FFiltroPesquisa + ' ' + aValue;
end;

procedure TfrmConsultarContasReceber.btnBaixarClick(Sender: TObject);
begin
  frmContasReceberBaixar.baixarContaReceber(DataSource1.DataSet.FieldByName('ID').AsString);

  if frmContasReceberBaixar.ModalResult = MROK then
    dmContasReceber.cdsContasReceber.Refresh;
end;

procedure TfrmConsultarContasReceber.btnDetalhesClick(Sender: TObject);
begin
  frmConsultarDetalhes.exibirContasReceberDetalhes(DataSource1.DataSet.FieldByName('ID').AsString);
  frmConsultarDetalhes.ShowModal;
end;

procedure TfrmConsultarContasReceber.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmConsultarContasReceber.btnFiltrarClick(Sender: TObject);
begin
  SplitView1.Opened := not SplitView1.Opened;
end;

procedure TfrmConsultarContasReceber.btnPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmConsultarContasReceber.cbFiltroStatusKeyPress(Sender: TObject;
  var Key: Char);
begin
    if key = #27 then
  begin
    cbFiltroStatus.ItemIndex := -1;
    HabilitarDatas(False);
  end;
end;

procedure TfrmConsultarContasReceber.cbFiltroTipoDataKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #27 then
  begin
    cbFiltroTipoData.ItemIndex := -1;
    HabilitarDatas(False);
  end;

end;

procedure TfrmConsultarContasReceber.cbFiltroTipoDataSelect(Sender: TObject);
begin
  HabilitarDatas(True);
end;

procedure TfrmConsultarContasReceber.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  btnBaixar.Enabled := DataSource1.DataSet.FieldByName('STATUS').AsString = 'A';
end;

procedure TfrmConsultarContasReceber.FiltrarData;
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
    0 : CampoData := 'DATA_VENDA';
    1 : CampoData := 'DATA_VENCIMENTO';
    2 : CampoData := 'DATA_RECEBIMENTO';
  end;

  if DateFiltroDataInicio.Checked then
  begin
    AdicionarFiltro('AND ' + CampoData + ' >= :DATAINICIO');
    dmContasReceber.cdsContasReceber.Params.CreateParam(TFieldType.ftDate, 'DATAINICIO', TParamType.ptInput);
    dmContasReceber.cdsContasReceber.ParamByName('DATAINICIO').AsDate := DateFiltroDataInicio.Date;

  end;

  if DateFiltroDataFim.Checked then
  begin
    AdicionarFiltro('AND ' + CampoData + ' <= :DATAFIM');
    dmContasReceber.cdsContasReceber.Params.CreateParam(TFieldType.ftDate, 'DATAFIM', TParamType.ptInput);
    dmContasReceber.cdsContasReceber.ParamByName('DATAFIM').AsDate := DateFiltroDataFim.Date;
  end;
end;

procedure TfrmConsultarContasReceber.FiltrarNumero;
begin
  if edtNumeroDocumento.Text = '' then
    exit;

  AdicionarFiltro(' AND NUMERO_DOCUMENTO = :NUMERODOCUMENTO');
  dmContasReceber.cdsContasReceber.Params.CreateParam(TFieldType.ftString, 'NUMERODOCUMENTO', TParamType.ptInput);
  dmContasReceber.cdsContasReceber.ParamByName('NUMERODOCUMENTO').AsString := edtNumeroDocumento.Text;
end;

procedure TfrmConsultarContasReceber.FiltrarParcela;
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
  dmContasReceber.cdsContasReceber.Params.CreateParam(TFieldType.ftString, 'PARCELA', TParamType.ptInput);
  dmContasReceber.cdsContasReceber.ParamByName('PARCELA').AsString := edtParcela.Text;
end;

procedure TfrmConsultarContasReceber.FiltrarStatus;
begin
  if cbFiltroStatus.ItemIndex = -1 then
    exit;

  case cbFiltroStatus.ItemIndex of
    0 : AdicionarFiltro(' AND STATUS = ''A''');
    1 : AdicionarFiltro(' AND STATUS = ''B''');
    2 : AdicionarFiltro(' AND STATUS = ''C''');
  end;
end;

procedure TfrmConsultarContasReceber.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmConsultarContasReceber.HabilitarDatas(aValue: Boolean);
begin
  DateFiltroDataInicio.Enabled := aValue;
  DateFiltroDataFim.Enabled := aValue;
end;

procedure TfrmConsultarContasReceber.LimparFiltro;
begin
  FFiltroPesquisa := '';
end;

procedure TfrmConsultarContasReceber.Pesquisar;
var
  FiltroPesquisa : String;
begin
  SplitView1.Opened := false;
  LimparFiltro;
  dmContasReceber.cdsContasReceber.Params.Clear;

  FiltrarData;
  FiltrarNumero;
  FiltrarParcela;
  FiltrarStatus;

  dmContasReceber.cdsContasReceber.Close;
  dmContasReceber.cdsContasReceber.CommandText := 'select * from contas_receber where 1=1' + FFiltroPesquisa;
  dmContasReceber.cdsContasReceber.Open;

  lblQtdRegistros.Caption := Format('Quantidade de Registros: %d', [DataSource1.DataSet.RecordCount]);
  lblTotalRecebimentos.Caption := 'Total de Recebimentos: R$ ' + TUtilitarios.FormatarValor(dmContasReceber.cdsContasReceber.FieldByName('TOTAL').AsString);
end;

end.
