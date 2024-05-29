unit finan.view.Caixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, finan.view.cadastroPadrao, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.WinXPanels, Vcl.WinXCtrls;

type
  TfrmCaixa = class(TformCadastroPadrao)
    edtNumeroDocumento: TEdit;
    Label2: TLabel;
    edtDescricao: TEdit;
    Label3: TLabel;
    edtValor: TEdit;
    Label5: TLabel;
    RadioGroup1: TRadioGroup;
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Pesquisar; override;
  end;

var
  frmCaixa: TfrmCaixa;

implementation

uses
  sistema.model.Caixa, finan.Utilitarios;

{$R *.dfm}

{ TformCadastroPadrao1 }


procedure TfrmCaixa.btnSalvarClick(Sender: TObject);
var
  LTipo : String;
begin
  if Trim(edtNumeroDocumento.Text) = '' then
  begin
    edtNumeroDocumento.SetFocus;
    Application.MessageBox('O campo de número do documento não pode estar em branco.', 'Aviso', MB_OK + MB_ICONINFORMATION);
    abort;
  end;

  if Trim(edtValor.Text) = '' then
  begin
    edtValor.SetFocus;
    Application.MessageBox('O campo de valor não pode estar em branco.', 'Aviso', MB_OK + MB_ICONINFORMATION);
    abort;
  end;

  if RadioGroup1.ItemIndex = -1 then
  begin
    Application.MessageBox('Selecione um tipo de lançamento.', 'Aviso', MB_OK + MB_ICONINFORMATION);
    abort;
  end;

  LTipo := 'R';
  if RadioGroup1.ItemIndex = 1 then
    LTipo := 'D';

  if DataSource1.State in [dsInsert] then
  begin
    dmcaixa.cdsCaixaid.AsString := TUtilitarios.GetId;
    dmCaixa.cdsCaixaData_Cadastro.AsDateTime := Now;
  end;

  dmCaixa.cdsCaixaNumero_Doc.AsString := Trim(edtNumeroDocumento.Text);
  dmCaixa.cdsCaixaDescricao.AsString := edtDescricao.Text;
  dmCaixa.cdsCaixaValor.AsCurrency := StrToFloat(edtValor.Text);
  dmCaixa.cdsCaixaTipo.AsString := LTipo;

  inherited;
end;

procedure TfrmCaixa.Pesquisar;
begin
  inherited;
  dmCaixa.cdsCaixa.Close;
  dmCaixa.cdsCaixa.CommandText := 'select * from caixa';
  dmCaixa.cdsCaixa.Open;
end;

end.
