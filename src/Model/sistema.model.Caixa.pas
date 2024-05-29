unit sistema.model.Caixa;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.Provider, Data.DB, Datasnap.DBClient, sistema.model.conexao;

type
  TdmCaixa = class(TDataModule)
    cdsCaixa: TClientDataSet;
    dspCaixa: TDataSetProvider;
    sqlCaixa: TFDQuery;
    cdsCaixaid: TStringField;
    cdsCaixaDescricao: TStringField;
    cdsCaixaNumero_Doc: TStringField;
    cdsCaixaValor: TFMTBCDField;
    cdsCaixaTipo: TStringField;
    cdsCaixaData_Cadastro: TDateField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmCaixa: TdmCaixa;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


end.
