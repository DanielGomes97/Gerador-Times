unit VariaveisGlobais;

interface

uses
   System.UITypes, FireDAC.Comp.Client, FMX.Controls, System.Classes;

var

  URLServerTS3: String = 'https://centerteamspeak.com/central/modules/servers/teamspeak3/viewer.php?sid=16968';
  PlayerAtivo: String  = '<img src="https://centerteamspeak.com/central/modules/servers/teamspeak3/img/16x16_player_on.png">';  //se for detectado ATIVO
  PlayerMutado: String = '<img src="https://centerteamspeak.com/central/modules/servers/teamspeak3/img/16x16_hardware_output_muted.png">'; //se for detectado MUTADO;
  InicioTag: String    = '<li><img src="https://centerteamspeak.com/central/modules/servers/teamspeak3/img/16x16_hardware_output_muted.png">';
  FimConteudo: String  = '</ul><li><img src="https://centerteamspeak.com/central/modules/servers/teamspeak3/img/16x16_channel_green.png">';
  CopySorteio: TStringList;

  HeightLstTIMES  : Single = 0;
  HeightFormulario: Integer;//
  HeightInicial   : Boolean = True;


  //******* TIPO MENSAGEM *******
  xMsgTipoSUCESSO    :  String = 'SUCESSO';
  xMsgTipoCONFIRMAÇÃO:  String = 'CONFIRMAÇÃO';
  xMsgTipoINFORMATIVA:  String = 'INFORMATIVA';
  xMsgTipoERRO       :  String = 'ERRO';

  //******* CORES DA JANELA *******
  xCorRED   : TAlphaColor = $FFDB5050;
  xCorBLUE  : TAlphaColor = $FF5072DB;
  xCorGREEN : TAlphaColor = $FF5EDB50;

  //******* MODO DARK / LIGHT *******
  UsingModeDARK: Boolean = true;
  // dark
  FundoDARK: TAlphaColor = $FF343434;
  FundoTransDARK: TAlphaColor = $FF434343;
  TextoDARK: TAlphaColor = TAlphaColors.Lightgray;

  // light
  FundoLIGHT: TAlphaColor = $FFFFFFFF;
  FundoTransLIGHT: TAlphaColor = $FFE6E6E6;
  TextoLIGHT: TAlphaColor = $FF545454;

  //Cores Mode DARK
  BackgroundDarkD: TAlphaColor = $FF00000;
  BackgroundWhiteD: TAlphaColor = $FF00000;
  TextWhiteD: TAlphaColor = $FF00000;
  TextDarkD: TAlphaColor = $FF00000;
  ColorWhiteD: TAlphaColor = $FF00000;
  ColorDarkD: TAlphaColor = $FF00000;
  ColorGrayD: TAlphaColor = $FF00000;



implementation
end.
