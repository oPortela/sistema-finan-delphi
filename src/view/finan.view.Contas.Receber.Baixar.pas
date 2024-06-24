unit finan.view.Contas.Receber.Baixar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, finan.view.Contas.Pagar.Baixar,
  System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmContasReceberBaixar = class(TfrmContasPagarBaixar)
    procedure btnCancelarClick(Sender: TObject);
    procedure btnBaixarClick(Sender: TObject);
  private
    { Private declarations }
    FID : String;
  public
    { Public declarations }
    procedure baixarContaReceber(ID : String);
  end;

var
  frmContasReceberBaixar: TfrmContasReceberBaixar;

implementation

uses
  sistema.model.Entidades.Conta.Receber, finan.Utilitarios,
  sistema.model.Contas.Receber, sistema.model.Entidades.Conta.Receber.Detalhes,
  sistema.model.usuarios;

{$R *.dfm}

procedure TfrmContasReceberBaixar.baixarContaReceber(ID: String);
var
  ContaReceber : TModelContaReceber;
begin
  FID := Trim(ID);
  if FID.IsEmpty then
    raise Exception.Create('ID do contas a pagar inválido!');

  ContaReceber := dmContasReceber.GetContaReceber(FID);
  try
    if ContaReceber.Status = 'B' then
      raise Exception.Create('Não é possível baixar um documento baixado!');

    if ContaReceber.Status = 'C' then
      raise Exception.Create('Não é possível baixar um documento cancelado!');

    lblDocumento.Caption := ContaReceber.Documento;
    lblParcela.Caption := ContaReceber.Parcela.ToString;
    lblVencimento.Caption := FormatDateTime('dd/mm/yyyy', ContaReceber.DataVencimento);
    lblValorAbatido.Caption := TUtilitarios.FormatarValor(ContaReceber.ValorAbatido);
    lblValorParcela.Caption := TUtilitarios.FormatarValor(ContaReceber.ValorParcela);
    edtObservacao.Text := '';
    edtValor.Text := '';

    Self.ShowModal;
  finally
    ContaReceber.Free;
  end;


end;

procedure TfrmContasReceberBaixar.btnBaixarClick(Sender: TObject);
var
  ContaReceberDetalhe : TModelContaReceberDetalhes;
  ContaReceber : TModelContaReceber;
  ValorAbater : Currency;
begin
  if Trim(edtObservacao.Text) = '' then
  begin
    edtObservacao.SetFocus;
    Application.MessageBox('A observação não pode ser vazia!', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  ValorAbater := 0;
  TryStrToCurr(edtValor.Text, ValorAbater);

  if ValorAbater <= 0 then
  begin
    edtValor.SetFocus;
    Application.MessageBox('O valor não pode ser menor ou igual a zero!', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  ContaReceber := dmContasReceber.GetContaReceber(FID);
  try
    if (ContaReceber.ValorAbatido + StrToCurr(edtValor.Text)) > ContaReceber.ValorParcela then
    begin
      Application.MessageBox('O valor digitado está acima do valor da parcela', 'Atenção', MB_OK + MB_ICONWARNING);
      abort;
    end;
  finally
    ContaReceber.Free;
  end;

  ContaReceberDetalhe := TModelContaReceberDetalhes.Create;
  try
    ContaReceberDetalhe.IdContaReceber := FID;
    ContaReceberDetalhe.Detalhes := edtObservacao.Text;
    ContaReceberDetalhe.Valor := ValorAbater;
    ContaReceberDetalhe.Data := Now;
    ContaReceberDetalhe.Usuario := dmUsuarios.GetUsuarioLogado.ID;

    try
      dmContasReceber.BaixarContaReceber(ContaReceberDetalhe);
      Application.MessageBox('Documento baixado com sucesso!', 'Baixado', MB_OK + MB_ICONINFORMATION);
      ModalResult := mrOk;
    except on E : Exception do
      Application.MessageBox(PWideChar(E.Message), 'Erro ao Baixar documento!', MB_OK + MB_ICONWARNING);
    end;

  finally
    ContaReceberDetalhe.Free;
  end;

end;

procedure TfrmContasReceberBaixar.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
