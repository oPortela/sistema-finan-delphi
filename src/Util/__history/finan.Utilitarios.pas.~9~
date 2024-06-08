unit finan.Utilitarios;

interface

uses
  Vcl.DBGrids;
type
  TUtilitarios = class
    class function GetId : String;
    class function LikeFind(Pesquisa : String; Grid : TDBGrid) : String;
    class function FormatoMoeda(aValue : Currency): String;
  end;

implementation

uses
  System.SysUtils;

{ TUtilitarios }

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


end.
