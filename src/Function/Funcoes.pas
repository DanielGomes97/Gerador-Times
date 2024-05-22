unit Funcoes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Platform, FMX.Memo;

  function CopyX(Conteudo, Inicio, Fim: String): String;
  function IfThen(Condicao: Boolean; True, False: Variant): Variant;
  procedure CopyMemoToClipboard(Texto: TMemo);
  procedure CopyToClipboard(Texto: TStringList);
  function LocateIn(PalavraProcurar: String; Texto: String): boolean;
  procedure CarregaComboBox(Cbo: TComboBox; Codigo: Integer; Descricao: String);
  procedure SubstituirTag(Texto: string);
  function ExtrairNomesDoHTML(html: string): TStringList;
  function ExtrairConteudoDoHTML(html: string): string;

implementation

uses VariaveisGlobais;

function CopyX(Conteudo, Inicio, Fim: String): String;
var
  Aux1, Aux2: Integer;
begin
    Result := '';
    Aux2 := 0;

    if (Pos(UpperCase(Fim),    UpperCase(Conteudo)) <> 0) or (Fim = '')    and
       (Pos(UpperCase(Inicio), UpperCase(Conteudo)) <> 0) or (Inicio = '') then
    begin
        if Inicio = '' then
           Aux1 := 1
        else
           Aux1 := Pos(UpperCase(Inicio), UpperCase(Conteudo)) + Length(Inicio);
        //
        if Fim = '' then
           Aux2 := Length(Conteudo) + 1
        else
           Aux2 := Pos(UpperCase(Fim), UpperCase(Conteudo), Aux2);

        Result := Copy(Conteudo, Aux1, Aux2 - Aux1);
    end;
end;

function IfThen(Condicao: Boolean; True, False: Variant): Variant;
begin
    if Condicao then
       Result := True
    else
       Result := False;
end;

procedure CopyMemoToClipboard(Texto: TMemo);
var
   ClipboardService: IFMXClipboardService;
begin
    if Supports(TPlatformServices.Current.GetPlatformService(IFMXClipboardService), IFMXClipboardService, ClipboardService) then
       if Texto.Lines.Text <> '' then
          ClipboardService.SetClipboard(Texto.Lines.Text);
end;

procedure CopyToClipboard(Texto: TStringList);
var
   ClipboardService: IFMXClipboardService;
begin
    if Supports(TPlatformServices.Current.GetPlatformService(IFMXClipboardService), IFMXClipboardService, ClipboardService) then
       if Texto.Text <> '' then
          ClipboardService.SetClipboard(Texto.Text);
end;

function LocateIn(PalavraProcurar: String; Texto: String): boolean;
begin
     Result := Pos(UpperCase(PalavraProcurar), UpperCase(Texto)) > 0
end;

procedure CarregaComboBox(Cbo: TComboBox; Codigo: Integer; Descricao: String);
begin
    if Cbo.Items.Count = 0  then
       Cbo.BeginUpdate;
    Cbo.Items.Add(Descricao);
    Cbo.ListItems[Cbo.Items.Count - 1].Tag := Codigo;
end;

procedure SubstituirTag(Texto: string);
begin
    Texto := StringReplace(texto, PlayerAtivo, PlayerMutado, [rfReplaceAll, rfIgnoreCase]);
end;

function ExtrairNomesDoHTML(html: string): TStringList;
var
  startPos, endPos: Integer;
  nome: string;
begin
    Result := TStringList.Create;
    SubstituirTag(html); //Replace texto dentro do html, pra ficar no padrão
    startPos := Pos(InicioTag, html); //
    while True do
    begin
        if startPos = 0 then
           Break;

        endPos := Pos('</li>', html, startPos);
        if endPos = 0 then
           Break;

        nome := Copy(html, startPos + Length(InicioTag), endPos - (startPos + Length(InicioTag)));  // Extrai o nome desejado
        Result.Add(nome);// Adicionar nome no stringlist
        startPos := endPos + Length('</li>'); // Atualize a posição inicial para a próxima iteração
    end;
end;

function ExtrairConteudoDoHTML(html: string): string;
var
  startPos, endPos: Integer;
  TextoInicio, TextoFim: String;
begin
    Result := '';
    TextoInicio := NomeSalaInicio;
    TextoFim    := NomeSalaFinal;

    startPos := Pos(TextoInicio, html);   // Encontre a posição inicial do texto desejado
    if startPos > 0 then
    begin
        endPos := Pos(TextoFim, html, startPos);

        if endPos > startPos then
           Result := Copy(html, startPos + Length(TextoInicio), endPos - (startPos + Length(TextoInicio))); // Extrai o nome desejado
    end;
end;

end.
