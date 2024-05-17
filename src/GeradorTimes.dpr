program GeradorTimes;

uses
  System.StartUpCopy,
  FMX.Forms,
  uPrincipal in 'Unit\uPrincipal.pas' {FrmPrincipal},
  fTimes in 'Frames\fTimes.pas' {FrameTimes: TFrame},
  uResultado in 'Unit\uResultado.pas' {FrmResultado},
  uLoading in 'Function\uLoading.pas',
  VariaveisGlobais in 'Unit\VariaveisGlobais.pas',
  Funcoes in 'Function\Funcoes.pas',
  uSplash in 'Unit\uSplash.pas' {FrmSplash},
  fMapas in 'Frames\fMapas.pas' {FrameMapas: TFrame},
  fMensagem in 'Frames\fMensagem.pas' {FrameMensagem: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmSplash, FrmSplash);
  Application.Run;
end.
