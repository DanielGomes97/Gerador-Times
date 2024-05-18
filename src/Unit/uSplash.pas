unit uSplash;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFrmSplash = class(TForm)
    Rectangle1: TRectangle;
    Image1: TImage;
    Timer1: TTimer;
    Label1: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSplash: TFrmSplash;

implementation

uses uPrincipal, VariaveisGlobais;

{$R *.fmx}

procedure TFrmSplash.FormCreate(Sender: TObject);
begin
    Timer1.Enabled := True;
    {
    HeightFormulario := Height;
    if Height >= screen.Height then
       HeightFormulario := Round(Screen.Height - 100);

    Height := HeightFormulario;  }
    //OnResize := FormResize;
end;

procedure TFrmSplash.FormResize(Sender: TObject);
begin
    // Ajusta o tamanho do formulário com base na resolução
    HeightFormulario := Height;
    if (Height > Screen.Height) then
    begin
        Height := Trunc(Screen.Height - 70);
        HeightFormulario := Height;
    end
    else
    begin
      //Self.Width := 720;
      //Self.Height := 480;
    end;
end;

procedure TFrmSplash.Timer1Timer(Sender: TObject);
begin
    Timer1.Enabled := False;
    if NOT Assigned(FrmPrincipal) then
       Application.CreateForm(TFrmPrincipal, FrmPrincipal);
    Application.MainForm := FrmPrincipal;
    FrmSplash.Close;
    FrmPrincipal.Show;
end;

end.
