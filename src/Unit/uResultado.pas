unit uResultado;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Clipboard, FMX.Platform, fMensagem; //area de transferencia;

type
  TFrmResultado = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Rectangle1: TRectangle;
    LstTimes: TListBox;
    Layout5: TLayout;
    Layout6: TLayout;
    Layout7: TLayout;
    LblFechar: TLabel;
    LblMapa2: TLabel;
    LblMapa1: TLabel;
    LblMapa0: TLabel;
    BtnCopiaSorteio: TRectangle;
    LblCopiaSorteio: TLabel;
    Layout8: TLayout;
    BtnSortearNovamente: TRectangle;
    Label1: TLabel;
    LstMapas: TListBox;
    BtnVoltar: TRectangle;
    Label2: TLabel;
    FrameMensagem1: TFrameMensagem;
    procedure MostrarTimes(ListBox: TListBox; Titulo: String; Players: TStringList);
    procedure BtnCopiaSorteioClick(Sender: TObject);
    procedure BtnSortearNovamenteClick(Sender: TObject);
    procedure LblFecharClick(Sender: TObject);
    procedure MostrarMapas(ListBox: TListBox; MapasList: TStringList);
    procedure BtnVoltarClick(Sender: TObject);
    procedure BtnVoltarMouseEnter(Sender: TObject);
    procedure BtnVoltarMouseLeave(Sender: TObject);
    procedure BtnCopiaSorteioMouseEnter(Sender: TObject);
    procedure BtnCopiaSorteioMouseLeave(Sender: TObject);
    procedure BtnSortearNovamenteMouseEnter(Sender: TObject);
    procedure BtnSortearNovamenteMouseLeave(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FrameMensagem1BtnCancelarClick(Sender: TObject);
    procedure FrameMensagem1BtnFecharClick(Sender: TObject);
    procedure FrameMensagem1BtnConfirmarClick(Sender: TObject);
  private

     { Private declarations }
  public
     { Public declarations }
  end;

var
  FrmResultado: TFrmResultado;

implementation

uses FTimes, VariaveisGlobais, Funcoes, uPrincipal, fMapas;

{$R *.fmx}

procedure TFrmResultado.BtnCopiaSorteioClick(Sender: TObject);
begin
    if CopySorteio.Text = '' then
       Exit;
    CopyToClipboard(CopySorteio);
    FrameMensagem1.MostraMensagem(xMsgTipoSUCESSO, 'Copiado para area de transferencia, cole onde quiser com CTRL + V');
end;

procedure TFrmResultado.BtnCopiaSorteioMouseEnter(Sender: TObject);
begin
    BtnCopiaSorteio.Opacity := 1;
end;

procedure TFrmResultado.BtnCopiaSorteioMouseLeave(Sender: TObject);
begin
    BtnCopiaSorteio.Opacity := 0.8;
end;

procedure TFrmResultado.BtnSortearNovamenteClick(Sender: TObject);
begin
    FrmPrincipal.SortearTimes.OnClick(Sender);
end;

procedure TFrmResultado.BtnSortearNovamenteMouseEnter(Sender: TObject);
begin
    BtnSortearNovamente.Opacity := 1;
end;

procedure TFrmResultado.BtnSortearNovamenteMouseLeave(Sender: TObject);
begin
    BtnSortearNovamente.Opacity := 0.8;
end;

procedure TFrmResultado.BtnVoltarClick(Sender: TObject);
begin
    FrmPrincipal.Show;
    Application.MainForm := FrmPrincipal;
    Close;
end;

procedure TFrmResultado.BtnVoltarMouseEnter(Sender: TObject);
begin
    BtnVoltar.Opacity := 1;
end;

procedure TFrmResultado.BtnVoltarMouseLeave(Sender: TObject);
begin
    BtnVoltar.Opacity := 0.8;
end;

procedure TFrmResultado.FormCreate(Sender: TObject);
begin
    Height := HeightFormulario;
end;

procedure TFrmResultado.FrameMensagem1BtnCancelarClick(Sender: TObject);
begin
    FrameMensagem1.BtnCancelarClick(Sender);
end;

procedure TFrmResultado.FrameMensagem1BtnConfirmarClick(Sender: TObject);
begin
    FrameMensagem1.BtnConfirmarClick(Sender);
end;

procedure TFrmResultado.FrameMensagem1BtnFecharClick(Sender: TObject);
begin
    FrameMensagem1.BtnFecharClick(Sender);
end;

procedure TFrmResultado.LblFecharClick(Sender: TObject);
begin
    FrmPrincipal.Show;
    Application.MainForm := FrmPrincipal;
    Close;
end;

procedure TFrmResultado.MostrarTimes(ListBox: TListBox; Titulo: String; Players: TStringList);
var
  Item: TListBoxItem;
  Frame: TFrameTimes;
  I, X: Integer;
  Tamanho: Single;
begin
    //item vazio na listbox...
    Item := TListBoxItem.Create(nil);
    Item.Text := '';
    Item.Width  := ListBox.Width / 2;
    Item.Margins.Top    := 2;
    Item.Margins.Left   := 5;
    Item.Margins.Right  := 5;
    Item.Margins.Bottom := 5;
    Item.Selectable     := false;

    //criar o frame...
    Frame := TFrameTimes.Create(Item);
    Frame.Parent := Item;
    Frame.Align := TAlignLayout.Client;
    Frame.LblTituloTime.Text := Titulo;

    if HeightInicial then
    begin
        HeightInicial := False;
        ListBox.ItemHeight   := 0;
        Tamanho := 0;
        HeightLstTIMES := 0;
    end;

    if HeightLstTIMES = 0 then
       Tamanho := Frame.LoTopo.Height + Frame.LblPlayer0.Height;
    for X := 1 to Frame.ComponentCount - 1 do
    begin
        if Frame.Components[X] is TLabel then
            if (Frame.Components[X] as TLabel).Text = '{falied}' then
               (Frame.Components[X] as TLabel).Text := '';
    end;

    for I := 0 to Players.Count -1 do
    begin
        for X := 1 to Frame.ComponentCount - 1 do
        begin
            if Frame.Components[X] is TLabel then
               if (Frame.Components[X] as TLabel).Name = 'LblPlayer' + IntToStr(I) then
               begin
                   (Frame.Components[X] as TLabel).Text := Players[I];
                   if HeightLstTIMES = 0 then
                      Tamanho := Tamanho + 23;
                   break;
               end;
        end;
    end;

    if HeightLstTIMES = 0 then
       HeightLstTIMES :=  Tamanho;
    ListBox.ItemHeight := HeightLstTIMES;
    ListBox.AddObject(Item);
end;

procedure TFrmResultado.MostrarMapas(ListBox: TListBox; MapasList: TStringList);
var
  Item: TListBoxItem;
  Frame: TFrameMapas;
  I, X, Y: Integer;
begin
    //item vazio na listbox...
    Item := TListBoxItem.Create(nil);
    Item.Text := '';
    Item.Width  := ListBox.Width;// / 2;
    //Item.Margins.Top    := 5;
    Item.Margins.Left   := 5;
    Item.Margins.Right  := 5;
    Item.Margins.Bottom := 5;
    Item.Selectable     := false;

    //criar o frame...
    Frame := TFrameMapas.Create(Item);
    Frame.Parent := Item;
    Frame.Align := TAlignLayout.Client;

    for I := 0 to MapasList.Count -1 do
    begin
        for X := 1 to Frame.ComponentCount - 1 do
        begin
            if Frame.Components[X] is TLabel then
               if (Frame.Components[X] as TLabel).Name = 'LblMapa' + IntToStr(I) then
               begin
                   (Frame.Components[X] as TLabel).Text := MapasList[I];

                   for Y := 1 to Frame.ComponentCount - 1 do //associar a imagem do mapa..
                   begin
                       if Frame.Components[Y] is TImage then
                          if (Frame.Components[Y] as TImage).Name = 'Img' + IntToStr(I) then
                          begin
                              (Frame.Components[Y] as TImage).Bitmap := Frame.ExibiImagem(Copy(MapasList[I], 5, MapasList[I].Length)).Bitmap;
                              break;
                          end;
                   end;
                   break;
               end;
        end;
    end;

    ListBox.ItemHeight := 190;//Tamanho;
    ListBox.AddObject(Item);
end;

end.
