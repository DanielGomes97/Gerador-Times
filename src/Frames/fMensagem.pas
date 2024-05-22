unit fMensagem;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.Effects, FMX.Edit;

type
  TFrameMensagem = class(TFrame)
    Rectangle1: TRectangle;
    Layout1: TLayout;
    RFundoMensagem: TRectangle;
    RBackgroundTopo: TRectangle;
    LblTituloMensagem: TLabel;
    BtnFechar: TRectangle;
    LblTextoMensagem: TLabel;
    Layout2: TLayout;
    BtnConfirmar: TRectangle;
    LblConfirmar: TLabel;
    BtnCancelar: TRectangle;
    LblCancelar: TLabel;
    Label5: TLabel;
    ShadowEffect1: TShadowEffect;
    Layout3: TLayout;
    ImgConfirmacao: TImage;
    ImgInformacao: TImage;
    ImgSucesso: TImage;
    Layout4: TLayout;
    Layout6: TLayout;
    procedure MostraMensagem(TipoJanela, Texto: String; MostraMsg: Boolean = true);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnConfirmarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);

  private
    procedure EsconderImagens;
    procedure PainelMensagemPadrao;
    procedure MudarCor(CorFundo, CorTexto: TAlphaColor);
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses VariaveisGlobais;

procedure TFrameMensagem.BtnCancelarClick(Sender: TObject);
begin
    if BtnCancelar.Tag = 0 then
    begin
        BtnConfirmar.Tag := 0;
        MostraMensagem('','', False);
    end;
end;

procedure TFrameMensagem.BtnConfirmarClick(Sender: TObject);
begin
    if BtnConfirmar.Tag = 0 then
    begin
        MostraMensagem('','', False);
        exit;
    end;
end;

procedure TFrameMensagem.BtnFecharClick(Sender: TObject);
begin
    MostraMensagem('','', False);
    BtnConfirmar.Tag := 0;
    BtnCancelar.Tag  := 0;
end;

procedure TFrameMensagem.EsconderImagens;
begin
    ImgConfirmacao.Visible := False;
    ImgInformacao.Visible := False;
    ImgSucesso.Visible := False;
end;

procedure TFrameMensagem.PainelMensagemPadrao;
var
  WidthPainel: Single;
begin
    WidthPainel := (Layout4.Width / 2) - 10;
    BtnConfirmar.Align := TAlignLayout.Left;
    BtnConfirmar.Visible := True;
    BtnCancelar.Align  := TAlignLayout.Right;
    BtnCancelar.Width  := WidthPainel - 5;
    BtnCancelar.Visible := True;
    BtnConfirmar.Width := WidthPainel;
    LblTextoMensagem.Visible := True;
end;

procedure TFrameMensagem.MudarCor(CorFundo, CorTexto: TAlphaColor);
begin
    RFundoMensagem.Fill.Color := CorFundo;//cor fundo
    LblTextoMensagem.TextSettings.FontColor := CorTexto; //cor texto
end;

procedure TFrameMensagem.MostraMensagem(TipoJanela, Texto: String; MostraMsg: Boolean = true);
begin
    visible := MostraMsg;
    if not MostraMsg then
      exit;

    Layout1.Width := Width - 80;
    MudarCor(FundoDARK, TextoDARK); //escuro

    LblTituloMensagem.Text := 'Mensagem do sistema';
    LblTextoMensagem.Text  := Texto;
    PainelMensagemPadrao;
    EsconderImagens;

    if (TipoJanela = xMsgTipoSUCESSO) or (TipoJanela = xMsgTipoINFORMATIVA) or (TipoJanela = xMsgTipoERRO) then//OK
    begin
        if TipoJanela = xMsgTipoSUCESSO     then
           ImgSucesso.Visible := True;
        if TipoJanela = xMsgTipoINFORMATIVA then
           ImgInformacao.Visible := True;

        BtnCancelar.Visible := False;
        BtnConfirmar.Align := TAlignLayout.Client;
    end;

    if TipoJanela = xMsgTipoCONFIRMAÇÃO then //CONFIRMAR/ CANCELAR
       ImgConfirmacao.Visible := True;
end;

end.
