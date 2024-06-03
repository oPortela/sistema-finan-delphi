unit finan.view.cadastroPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.WinXPanels, Data.DB,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, System.ImageList, Vcl.ImgList, Vcl.WinXCtrls;

type
  TformCadastroPadrao = class(TForm)
    PnlPrincipal: TCardPanel;
    cardCadastro: TCard;
    cardPesquisa: TCard;
    pnlPesquisa: TPanel;
    pnlPesquisaBotoes: TPanel;
    pnlGrid: TPanel;
    DBGrid1: TDBGrid;
    edtPesquisar: TEdit;
    Label1: TLabel;
    btnPesquisar: TButton;
    ImageList1: TImageList;
    btnFechar: TButton;
    btnIncluir: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    btnImprimir: TButton;
    Panel1: TPanel;
    btnCancelar: TButton;
    btnSalvar: TButton;
    DataSource1: TDataSource;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure HabilitarBotoes;
    procedure LimparCampos;
  public
    { Public declarations }
    protected
      procedure Pesquisar; virtual;
  end;

var
  formCadastroPadrao: TformCadastroPadrao;

implementation

uses
  Datasnap.DBClient;

{$R *.dfm}

procedure TformCadastroPadrao.btnAlterarClick(Sender: TObject);
begin
  TClientDataSet(DataSource1.DataSet).Edit;            //Coloca em modo de edi��o.
  PnlPrincipal.ActiveCard := cardCadastro;
end;

procedure TformCadastroPadrao.btnCancelarClick(Sender: TObject);
begin
  TClientDataSet(DataSource1.DataSet).Cancel;
  PnlPrincipal.ActiveCard := cardPesquisa;
end;

procedure TformCadastroPadrao.btnExcluirClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja realmente excluir o registro?', 'Pergunta', MB_YESNO + MB_ICONQUESTION) <> mrYes then
    exit;

  try
    TClientDataSet(DataSource1.DataSet).Delete;
    TClientDataSet(DataSource1.DataSet).ApplyUpdates(0);
    Application.MessageBox('Resgistro exclu�do com sucesso!', 'Exclu�do', MB_OK + MB_ICONINFORMATION);
    Pesquisar;
  except
    on E: Exception do
      Application.MessageBox(PWideChar(E.Message), 'Erro ao excluir registro', MB_OK + MB_ICONERROR);
  end;
end;

procedure TformCadastroPadrao.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TformCadastroPadrao.btnIncluirClick(Sender: TObject);
begin
  LimparCampos;
  TClientDataSet(DataSource1.DataSet).Insert;
  PnlPrincipal.ActiveCard := cardCadastro;
end;

procedure TformCadastroPadrao.btnPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TformCadastroPadrao.btnSalvarClick(Sender: TObject);
var
  Mensagem: String;
begin
  Mensagem := 'Registro alterado com sucesso';

  if DataSource1.State in [dsInsert] then
  begin
  Mensagem := 'Registro inclu�do com sucesso';
  end;

  TClientDataSet(DataSource1.DataSet).Post;
  TClientDataSet(DataSource1.DataSet).ApplyUpdates(0);
  Application.MessageBox(PWidechar(Mensagem), 'Sucesso', MB_OK + MB_ICONINFORMATION);

  Pesquisar;

  PnlPrincipal.ActiveCard := cardPesquisa;
end;

procedure TformCadastroPadrao.FormShow(Sender: TObject);
begin
  PnlPrincipal.ActiveCard := cardPesquisa;
  Pesquisar;
end;

procedure TformCadastroPadrao.HabilitarBotoes;
begin
  btnExcluir.Enabled := not DataSource1.DataSet.IsEmpty;
  btnAlterar.Enabled := not DataSource1.DataSet.IsEmpty;
end;

procedure TformCadastroPadrao.LimparCampos;
var
  Contador : Integer;
begin
  for Contador := 0 to Pred(ComponentCount) do
  begin
    if Components[Contador] is TCustomEdit then
      TCustomEdit(Components[Contador]).Clear
    else if Components[Contador] is TToggleSwitch then
      TToggleSwitch(Components[Contador]).State := tssOn
    else if Components[Contador] is TRadioGroup then
      TRadioGroup(Components[Contador]).ItemIndex := -1;
  end;
end;

procedure TformCadastroPadrao.Pesquisar;
begin
  HabilitarBotoes;
end;

end.
