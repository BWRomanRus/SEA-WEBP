unit OneUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,seaWEBP,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Timer1: TTimer;
    grid: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}
procedure GenerateAlphaGrid(img: TImage; color1, color2: TColor; cellSize: integer);
var
  columns, rows, i, j: Integer;
  baseCellWidth, baseCellHeight, extraWidth, extraHeight: Integer;
  currentX, currentY: Integer;
  curCellWidth, curCellHeight: Integer;
begin
  if (img = nil) or (cellSize <= 0) then Exit;

  // ќпредел€ем количество столбцов и строк, округл€€ вверх (чтобы покрыть всю ширину и высоту)
  columns := (img.Width + cellSize - 1) div cellSize;
  rows := (img.Height + cellSize - 1) div cellSize;

  // ¬ычисл€ем базовый размер €чейки по ширине и высоте, а также остаток (количество пикселей, которые не дел€тс€ равномерно)
  baseCellWidth := img.Width div columns;
  extraWidth := img.Width mod columns;

  baseCellHeight := img.Height div rows;
  extraHeight := img.Height mod rows;

  // ѕодготавливаем Bitmap дл€ TImage
  if img.Picture = nil then
    img.Picture := TPicture.Create;
  if img.Picture.Bitmap = nil then
    img.Picture.Bitmap := TBitmap.Create;
  img.Picture.Bitmap.Width := img.Width;
  img.Picture.Bitmap.Height := img.Height;

  // –исуем €чейки. ќстаточные пиксели распредел€ем по первым столбцам и строкам, чтобы в сумме ширина столбцов ровно равн€лась img.Width,
  // а высота строк Ц img.Height.
  currentY := 0;
  for j := 0 to rows - 1 do
  begin
    // ƒл€ j-й строки к базовой высоте прибавл€ем 1 пиксель, если еще есть не распределЄнные остатки
    curCellHeight := baseCellHeight;
    if j < extraHeight then
      Inc(curCellHeight);

    currentX := 0;
    for i := 0 to columns - 1 do
    begin
      // ƒл€ i-го столбца аналогично Ц прибавл€ем 1 пиксель, если есть остаток
      curCellWidth := baseCellWidth;
      if i < extraWidth then
        Inc(curCellWidth);

      // ќпредел€ем цвет €чейки по принципу шахматной доски:
      // если сумма индексов четна€ Ц первый цвет, иначе Ц второй.
      if ((i + j) mod 2 = 0) then
        img.Picture.Bitmap.Canvas.Brush.Color := color1
      else
        img.Picture.Bitmap.Canvas.Brush.Color := color2;

      // –исуем пр€моугольник текущей €чейки
      img.Picture.Bitmap.Canvas.FillRect(Rect(currentX, currentY, currentX + curCellWidth, currentY + curCellHeight));

      Inc(currentX, curCellWidth);
    end;
    Inc(currentY, curCellHeight);
  end;

  img.Invalidate;
end;




procedure TForm2.Button1Click(Sender: TObject);
begin
if opendialog1.Execute() then
loadSEAWEBP(opendialog1.FileName,image1);
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
WebPAnimStop;
webp_unload;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
GenerateAlphaGrid(grid,$00FFF9F2,clwhite,15);
loadw;
end;

procedure TForm2.FormResize(Sender: TObject);
begin
grid.Picture:=nil;
grid.Picture.Graphic:=nil;
GenerateAlphaGrid(grid,$00FFF9F2,clwhite,15);
end;

end.
