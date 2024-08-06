unit finan.view.Caixa.Saldo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.WinXPanels, System.SysUtils, System.DateUtils;

type
  TfrmCaixaSaldo = class(TForm)
    pnlPrincipal: TPanel;
    pnlPesquisar: TPanel;
    pnlContent: TPanel;
    btnPesquisar: TButton;
    ImageList1: TImageList;
    dateInicio: TDateTimePicker;
    dateFim: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    StackPanel1: TStackPanel;
    Panel1: TPanel;
    lblSaldoInicial: TLabel;
    Label4: TLabel;
    Panel2: TPanel;
    lblTotalEntradas: TLabel;
    Label6: TLabel;
    Panel3: TPanel;
    lblTotalSaidas: TLabel;
    Label8: TLabel;
    Panel4: TPanel;
    lblSaldoParcial: TLabel;
    Label10: TLabel;
    Panel5: TPanel;
    lblSaldoFinal: TLabel;
    Label12: TLabel;
    pnlLineHeader: TPanel;
    Panel6: TPanel;
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
    procedure Pesquisar;
  public
    { Public declarations }
  end;

var
  frmCaixaSaldo: TfrmCaixaSaldo;

implementation

uses
  sistema.model.Entidades.Caixa.Resumo, sistema.model.Caixa, finan.Utilitarios;

{$R *.dfm}

{ TfrmCaixaSaldo }

procedure TfrmCaixaSaldo.btnPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCaixaSaldo.FormShow(Sender: TObject);
begin
  dateInicio.date := IncDay(Now, -7);
  Pesquisar;
end;

procedure TfrmCaixaSaldo.Pesquisar;
var
  ResumoCaixa : TModelResumoCaixa;
begin
  lblSaldoInicial.Caption := '';
  lblTotalEntradas.Caption := '';
  lblTotalSaidas.Caption := '';
  lblSaldoParcial.Caption := '';
  lblSaldoFinal.Caption := '';

  ResumoCaixa := dmCaixa.ResumoCaixa(dateInicio.Date, dateFim.Date);
  try
    lblSaldoInicial.Caption := TUtilitarios.FormatoMoeda(ResumoCaixa.SaldoInicial);
    lblTotalEntradas.Caption := TUtilitarios.FormatoMoeda(ResumoCaixa.TotalEntradas);
    lblTotalSaidas.Caption := TUtilitarios.FormatoMoeda(ResumoCaixa.TotalSaidas);
    lblSaldoParcial.Caption := TUtilitarios.FormatoMoeda(ResumoCaixa.SaldoParcial);
    lblSaldoFinal.Caption := TUtilitarios.FormatoMoeda(ResumoCaixa.SaldoFinal);
  finally
    ResumoCaixa.Free;
  end;
end;

end.
