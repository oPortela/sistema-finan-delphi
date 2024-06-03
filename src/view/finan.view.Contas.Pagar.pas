unit finan.view.Contas.Pagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, finan.view.cadastroPadrao, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.WinXPanels, sistema.model.Contas.Pagar;

type
  TfrmContasPagar = class(TformCadastroPadrao)
    Label2: TLabel;
    edtDescricao: TEdit;
    Label3: TLabel;
    edtNumeroDocumento: TEdit;
    Edit2: TEdit;
    Label4: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    protected
      procedure Pesquisar; override;
  end;

var
  frmContasPagar: TfrmContasPagar;

implementation

uses
  finan.Utilitarios;

{$R *.dfm}

{ TfrmContasPagar }

procedure TfrmContasPagar.Pesquisar;
var
  FiltroPesquisa : String;
begin
  FiltroPesquisa := TUtilitarios.LikeFind(edtPesquisar.Text, DBGrid1);
  dmContasPagar.cdsContasPagar.Close;
  dmContasPagar.cdsContasPagar.CommandText := 'select * from contas_pagar where 1=1' + FiltroPesquisa;
  dmContasPagar.cdsContasPagar.Open;
  inherited;
end;

end.
