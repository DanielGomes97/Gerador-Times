unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.StdCtrls, FMX.Objects, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  FMX.Layouts, FMX.ListBox, System.NetEncoding, FMX.WebBrowser,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  uLoading, //unit loading
  System.JSON,   //manipular JSON
  FMX.Clipboard, FMX.Platform, fMensagem; //area de transferencia

type
  TFrmPrincipal = class(TForm)
    MemoNomes: TMemo;
    SortearTimes: TRectangle;
    Label1: TLabel;
    Label2: TLabel;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Rectangle2: TRectangle;
    LoWeb: TLayout;
    Rectangle4: TRectangle;
    Layout7: TLayout;
    Layout8: TLayout;
    Layout6: TLayout;
    Layout9: TLayout;
    Layout10: TLayout;
    Layout11: TLayout;
    LblFechar: TLabel;
    WebBrowser1: TWebBrowser;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    BtnReloadWeb: TImage;
    Layout5: TLayout;
    Layout12: TLayout;
    Layout13: TLayout;
    Layout14: TLayout;
    CboQuantidade: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Layout16: TLayout;
    Label6: TLabel;
    Layout17: TLayout;
    GridPanelLayout1: TGridPanelLayout;
    RbTotalEquipe: TRadioButton;
    RbMaxPlayerEquipe: TRadioButton;
    BtnBuscaNomes: TRectangle;
    Label7: TLabel;
    Layout18: TLayout;
    StyleBook1: TStyleBook;
    Layout19: TLayout;
    LblQtdNome: TLabel;
    FrameMensagem1: TFrameMensagem;
    VertScrollBox1: TVertScrollBox;
    procedure MemoNomesChangeTracking(Sender: TObject);
    procedure SortearTimesClick(Sender: TObject);
    procedure WebBrowser1DidFinishLoad(ASender: TObject);
    procedure TerminateThread(Sender: TObject);
    procedure BtnReloadWebClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LblFecharClick(Sender: TObject);
    procedure BtnBuscaNomesClick(Sender: TObject);
    procedure MemoNomesKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure SortearTimesMouseEnter(Sender: TObject);
    procedure SortearTimesMouseLeave(Sender: TObject);
    procedure BtnBuscaNomesMouseEnter(Sender: TObject);
    procedure BtnBuscaNomesMouseLeave(Sender: TObject);
    procedure FrameMensagem1BtnCancelarClick(Sender: TObject);
    procedure FrameMensagem1BtnFecharClick(Sender: TObject);
    procedure FrameMensagem1BtnConfirmarClick(Sender: TObject);

  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses fTimes, uResultado, VariaveisGlobais, Funcoes;

{$R *.fmx}

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
    Height := HeightFormulario;
    LoWeb.Visible := False; //Layout com fundo escuro, ajuda na visualização durante a tela de carregamento.

    CboQuantidade.Items.Clear;
    CarregaComboBox(CboQuantidade, 8, 'Automático');
    CarregaComboBox(CboQuantidade, 4, 'Max 4 jogadores por equipe');
    CarregaComboBox(CboQuantidade, 5, 'Max 5 jogadores por equipe');
    CarregaComboBox(CboQuantidade, 6, 'Max 6 jogadores por equipe');
    CarregaComboBox(CboQuantidade, 7, 'Max 7 jogadores por equipe');
    CarregaComboBox(CboQuantidade, 8, 'Max 8 jogadores por equipe');
    CboQuantidade.EndUpdate;

    CboQuantidade.ItemIndex := 0;
    RbTotalEquipe.IsChecked := true;
end;

procedure TFrmPrincipal.FrameMensagem1BtnCancelarClick(Sender: TObject);
begin
    FrameMensagem1.BtnCancelarClick(Sender);

end;

procedure TFrmPrincipal.FrameMensagem1BtnConfirmarClick(Sender: TObject);
begin
    FrameMensagem1.BtnConfirmarClick(Sender);
end;

procedure TFrmPrincipal.FrameMensagem1BtnFecharClick(Sender: TObject);
begin
    FrameMensagem1.BtnFecharClick(Sender);
end;

procedure TFrmPrincipal.MemoNomesChangeTracking(Sender: TObject);
begin
    if MemoNomes.Lines.Text <> '' then   //conta total de linhas no memo enquanto estiver conteudo.
       LblQtdNome.Text := MemoNomes.Lines.Count.ToString;
    MemoNomes.ReadOnly := IfThen(MemoNomes.Lines.Count >= 99, True, False);  //limite de 99 linhas, deixar somente modo leitura.
end;

procedure TFrmPrincipal.MemoNomesKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
   if Key = vkBack then    //
      MemoNomes.ReadOnly := False;
end;

procedure TFrmPrincipal.SortearTimesClick(Sender: TObject);
var
  TeamA, TeamB, ListaNomes, Mapas, MapasSorteados: TStringList;
  NumeroAleatorio, I: Integer;
  xData: TDateTime;
  xHora: TTime;
begin
    HeightInicial := True;
    MemoNomes.Lines.Text := Trim(MemoNomes.Lines.Text);
    if Trim(MemoNomes.Lines.Text) = '' then
    begin
        FrameMensagem1.MostraMensagem(xMsgTipoINFORMATIVA, 'Você não adicionou nenhum participante na lista para sorteio');
        exit;
    end;
    NumeroAleatorio := 0;

    TeamA := TStringList.Create;
    TeamB := TStringList.Create;
    Mapas := TStringList.Create;
    MapasSorteados  := TStringList.Create;
    ListaNomes := TStringList.Create;
    CopySorteio      := TStringList.Create;

    //Adicionando nome dos mapas a ser sorteados.
    MapasSorteados.Clear;
    Mapas.Clear;
    Mapas.Add('Porto-T');
    Mapas.Add('Satelite-T');
    Mapas.Add('Olho de Águia 1.0');
    Mapas.Add('México');
    Mapas.Add('Ankara-T');
    //Mapas.Add('Tanques');
    Mapas.Add('Sub Base-T');
    Mapas.Add('Viuva Negra-T');

    for I := 1 to 3 do //sortear somente 3 mapas
    begin
        if Mapas.Count > 0 then
        begin
            NumeroAleatorio := Random(Mapas.Count); //sorteia aleatorio
            MapasSorteados.Add(I.ToString +'º. ' + Mapas[NumeroAleatorio]); //adiciona na nova variavel de sorteados.
        end;
        Mapas.Delete(NumeroAleatorio); //exclui o index da variavel principal, isso foi feito para não ter chance de ser sorteado o mesmo
    end;

    ListaNomes.Clear;
    for I := 0 to MemoNomes.Lines.Count - 1 do // remover linhas vazias...
    begin
        if MemoNomes.Lines[I] <> '' then
           ListaNomes.Add(MemoNomes.Lines[I]);
    end;
    MemoNomes.Text := ListaNomes.Text;

    for I := 0 to MemoNomes.Lines.Count -1 do
    begin
        if (TeamA.Count = CboQuantidade.ListItems[CboQuantidade.ItemIndex].Tag) and (TeamB.Count = CboQuantidade.ListItems[CboQuantidade.ItemIndex].Tag) then
           break;
        //esse sistema sorteia apenas 2 times.
        if ListaNomes.Count > 0 then
        begin
            NumeroAleatorio := Random(ListaNomes.Count);

            if I mod 2 = 0 then //se o sorteio for par
                TeamA.Add((TeamA.Count + 1).ToString +'. ' + ListaNomes[NumeroAleatorio])
            else // impar
                TeamB.Add((TeamB.Count + 1).ToString +'. ' + ListaNomes[NumeroAleatorio]);
            ListaNomes.Delete(NumeroAleatorio); // Remove o nome sorteado da lista, evitar duplicidade nos times.
        end;
    end;

    if (TeamA.Text = '') or (TeamB.Text = '') then
    begin
        FrameMensagem1.MostraMensagem(xMsgTipoERRO, 'Você precisa digitar no minimo de 2 jogador para sortear', true);
        Exit;
    end;

    if NOT Assigned(FrmResultado) then
       Application.CreateForm(TFrmResultado, FrmResultado);

    FrmResultado.LstTimes.Items.Clear;
    FrmResultado.MostrarTimes(FrmResultado.LstTimes, 'TEAM 1 - GR', TeamA);
    FrmResultado.MostrarTimes(FrmResultado.LstTimes, 'TEAM 2 - BL', TeamB);

    //SORTEAR MAPAS
    FrmResultado.LstMapas.Items.Clear;
    FrmResultado.MostrarMapas(FrmResultado.LstMapas, MapasSorteados);

    xData := Now;
    xHora := Now;
    //armazenando essa variavel pra caso o usuario queira copiar e colar em outro lugar o resultado.
    //proxima tela "Resultado", terá o botão 'COPIAR SORTEIO' e ficará disponivel na area de transferencia.
    CopySorteio.Text := 'Data: ' +  DateToStr(xData) + '       Horario: ' + TimeToStr(xHora) + sLineBreak +
                        '============================' + sLineBreak +
                        '===== {  TEAM 1 - GR } =====' + sLineBreak +
                        TeamA.Text + sLineBreak +
                        '===== {  TEAM 2 - BL } =====' + sLineBreak +
                        TeamB.Text + sLineBreak +
                        '===== {  MAPAS SORTEADOS } =====' + sLineBreak +
                        MapasSorteados.Text + sLineBreak +
                        IfThen(ListaNomes.Text <> '', '===== {  Jogadores não sorteados } =====' + sLineBreak + ListaNomes.Text, '');

    //deletar da memoria
    TeamA.Free; TeamB.Free; Mapas.Free; ListaNomes.Free;  MapasSorteados.Free;
    FrmPrincipal.Hide;//esconder principal
    Application.MainForm := FrmResultado; //tornar o resultado formulario principal
    FrmResultado.Show; //mostrar o formulario resultado.
end;


procedure TFrmPrincipal.SortearTimesMouseEnter(Sender: TObject);
begin
    SortearTimes.Opacity := 1; //ao passar o mouse em cima.
end;

procedure TFrmPrincipal.SortearTimesMouseLeave(Sender: TObject);
begin
    SortearTimes.Opacity := 0.8; // ao remover o mouse de cima
end;

procedure TFrmPrincipal.BtnBuscaNomesClick(Sender: TObject);
var
  Th: TThread;
  ConteudoEx: String;
  Nomes: TStringList;
begin
    LoWeb.Visible := true;
    MemoNomes.Lines.Clear;
    MemoNomes.ReadOnly := true;
    WebBrowser1.Visible := False;

    TLoading.Show(FrmPrincipal, 'Tentando localizar jogadores dentro do servidor teamspeak3, aguarde...');
    //essa unit de loading foi distribuido por Heber, do canal 99 Coder, ele tem bastante conteudo relacionado a delphi.

    Th := TThread.CreateAnonymousThread(procedure
    begin
        RESTClient1.BaseURL := URLServerTS3;
        RESTRequest1.Execute;
        ConteudoEx := ExtrairConteudoDoHTML(RESTResponse1.Content);  // Chame a função para extrair o nome
        Nomes := ExtrairNomesDoHTML(ConteudoEx);

        TThread.Synchronize(TThread.CurrentThread, procedure
        begin
            if Nomes.Text <> '' then
                MemoNomes.Text := Nomes.Text
            else
                FrameMensagem1.MostraMensagem(xMsgTipoERRO, 'Não foi possível encontrar jogadores na sala de espera', true);
            LoWeb.Visible := False;
            MemoNomes.ReadOnly := False;
        end);
    end);
              //th.FreeOnTerminate := true; caso seja false, ele não é matado automaticamente da memoria.
    th.OnTerminate := TerminateThread;
    th.Start;
end;

procedure TFrmPrincipal.BtnBuscaNomesMouseEnter(Sender: TObject);
begin
    BtnBuscaNomes.Opacity := 1;
end;

procedure TFrmPrincipal.BtnBuscaNomesMouseLeave(Sender: TObject);
begin
    BtnBuscaNomes.Opacity := 0.8;
end;

procedure TFrmPrincipal.BtnReloadWebClick(Sender: TObject);
var
  Th: TThread;
begin
    LoWeb.Visible := true;
    WebBrowser1.Visible := False;
    TLoading.Show(FrmPrincipal, 'Listando jogadores no servidor teamspeak3, aguarde...');
    Th := TThread.CreateAnonymousThread(procedure
    begin
        TThread.Synchronize(TThread.CurrentThread, procedure
        begin
            WebBrowser1.Navigate(URLServerTS3);
        end);
    end);
    th.Start;
end;

procedure TFrmPrincipal.LblFecharClick(Sender: TObject);
begin
    LoWeb.Visible := False;
end;

procedure TFrmPrincipal.TerminateThread(Sender: TObject);
begin
    TLoading.Hide;
end;

procedure TFrmPrincipal.WebBrowser1DidFinishLoad(ASender: TObject);
begin
    TerminateThread(ASender);
    WebBrowser1.Visible := True;
end;
end.
