unit fMapas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, System.Math.Vectors,
  System.ImageList, FMX.ImgList, FMX.Controls3D, FMX.Layers3D;

type
  TFrameMapas = class(TFrame)
    Layout1: TLayout;
    LoTopo: TLayout;
    Rectangle2: TRectangle;
    LblTituloMapa: TLabel;
    LoCorpo: TLayout;
    Rectangle1: TRectangle;
    GridPanelLayout1: TGridPanelLayout;
    Layout2: TLayout;
    Img0: TImage;
    imgANK: TImage;
    imgVIUVA: TImage;
    imgOLHO: TImage;
    LblMapa0: TLabel;
    Layout3: TLayout;
    Img1: TImage;
    LblMapa1: TLabel;
    Layout4: TLayout;
    Img2: TImage;
    LblMapa2: TLabel;
    imgTANQ: TImage;
    imgPORTO: TImage;
    ImgSAT: TImage;
    ImgMEX: TImage;
    ImgSUB: TImage;
    ImgDARK: TImage;
     function ExibiImagem(NomeMapa: String): TImage;
  private

    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

function TFrameMapas.ExibiImagem(NomeMapa: String): TImage;
begin
    Result := ImgDARK;

    if imgVIUVA.Hint = NomeMapa then
       Result := imgVIUVA
    else if imgOLHO.Hint  = NomeMapa then
       Result := imgOLHO
    else if imgPORTO.Hint = NomeMapa then
       Result := imgPORTO
    //else if imgTANQ.Hint  = NomeMapa then
    //   Result := imgTANQ
    else if ImgSAT.Hint   = NomeMapa then
       Result := ImgSAT
    else if ImgMEX.Hint   = NomeMapa then
       Result := ImgMEX
    else if ImgSUB.Hint   = NomeMapa then
       Result := ImgSUB
    else if imgANK.Hint   = NomeMapa then
       Result := imgANK;
end;


end.
