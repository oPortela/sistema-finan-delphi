unit sistema.model.Contas.Receber;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.Provider, Data.DB, Datasnap.DBClient,
  sistema.model.conexao, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait;

type
  TdmContasReceber = class(TDataModule)
    cdsContasReceber: TClientDataSet;
    dspContasReceber: TDataSetProvider;
    sqlContasReceber: TFDQuery;
    cdsContasReceberid: TStringField;
    cdsContasRecebernumero_documento: TStringField;
    cdsContasReceberdescricao: TStringField;
    cdsContasReceberparcela: TIntegerField;
    cdsContasRecebervalor_parcela: TFMTBCDField;
    cdsContasRecebervalor_venda: TFMTBCDField;
    cdsContasRecebervalor_abatido: TFMTBCDField;
    cdsContasReceberdata_venda: TDateField;
    cdsContasReceberdata_cadastro: TDateField;
    cdsContasReceberdata_vencimento: TDateField;
    cdsContasReceberdata_recebimento: TDateField;
    cdsContasReceberstatus: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmContasReceber: TdmContasReceber;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.