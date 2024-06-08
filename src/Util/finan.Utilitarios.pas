unit finan.Utilitarios;

interface

uses
  Vcl.DBGrids;
type
  TUtilitarios = class
    class function GetId : String;
    class function LikeFind(Pesquisa : String; Grid : TDBGrid) : String;
    class function FormatoMoeda(aValue : Currency): String;
    class function FormatarValor(aValue : Currency; Decimais : Integer = 2): String; overload;
    class function FormatarValor(aValue : String; Decimais : Integer = 2): String; overload;
    class procedure KeyPressValor(Sender: TObject; var Key: Char);
    class function TruncarValor(aValue : Currency; Decimais : Integer = 2): Currency;
  end;

implementation

uses
  System.SysUtils, Vcl.StdCtrls, Winapi.Windows, System.Math;

{ TUtilitarios }

class function TUtilitarios.FormatarValor(aValue: Currency;
  Decimais: Integer): String;
begin
  aValue := TruncarValor(aValue, Decimais);
  Result := FormatCurr('0.' + StringOfChar('0', Decimais), aValue);
end;

class function TUtilitarios.FormatarValor(aValue: String;
  Decimais: Integer): String;
var
  lValor : Currency;
begin
  lValor := 0;
  TryStrToCurr(aValue, lValor);
  Result := FormatarValor(lValor, Decimais);
end;

class function TUtilitarios.FormatoMoeda(aValue: Currency): String;
begin
  Result := Format('%m', [aValue]);
end;

class function TUtilitarios.GetId: String;
begin
  Result := TGUID.NewGuid.toString;
  Result := StringReplace(Result, '{', '', [rFReplaceAll]);
  Result := StringReplace(Result, '}', '', [rFReplaceAll]);
end;

class procedure TUtilitarios.KeyPressValor(Sender: TObject; var Key: Char);
begin
  if key = FormatSettings.ThousandSeparator then
    Key := FormatSettings.DecimalSeparator;

  if not (CharInSet(Key, ['0'..'9', chr(8), FormatSettings.DecimalSeparator])) then
    Key := #0;

  if (Key = FormatSettings.DecimalSeparator) and (pos(Key, TEdit(Sender).text) > 0) then
    Key := #0;
end;

class function TUtilitarios.LikeFind(Pesquisa: String; Grid: TDBGrid): String;
var
  Lcontador: Integer;
begin
  Result := '';
  if Pesquisa.Trim.IsEmpty then
    exit;

  for Lcontador := 0 to Pred(Grid.Columns.Count) do
  begin
    Result := Result + Grid.Columns.Items[Lcontador].FieldName + ' LIKE ' + QuotedStr('%' + Trim(Pesquisa) + '%') + ' OR ';
  end;

  Result := ' AND ( ' + Copy(Result, 1, Length(Result) - 4) + ')';
end;


class function TUtilitarios.TruncarValor(aValue: Currency;
  Decimais: Integer): Currency;
var
  LFator : Double;
begin
  LFator := Power(10, Decimais);
  Result := Trunc(aValue * LFator) / LFator;
end;

end.
