unit fTimes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts;

type
  TFrameTimes = class(TFrame)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    LoTopo: TLayout;
    LoCorpo: TLayout;
    LblTituloTime: TLabel;
    LblPlayer0: TLabel;
    LblPlayer7: TLabel;
    LblPlayer6: TLabel;
    LblPlayer5: TLabel;
    LblPlayer4: TLabel;
    LblPlayer3: TLabel;
    LblPlayer2: TLabel;
    LblPlayer1: TLabel;
    Rectangle2: TRectangle;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
