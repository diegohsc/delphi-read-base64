unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  FMX.ExtCtrls, System.NetEncoding, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo,  JSON, IdCoderMIME;


type
  TForm1 = class(TForm)
    Button1: TButton;
    ImageViewer1: TImageViewer;
    Image1: TImage;
    Memo1: TMemo;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    function ConvertBase64(str64:string):TBitmap;
  private
    procedure Base64(str64: String);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure tform1.Base64(str64: String);
var
   Input, Output : TStringStream;
begin
   Input := TStringStream.Create(str64);
   Output := TStringStream.Create;
   try
      Input.Position :=0;
      TNetEncoding.Base64.Decode(Input,Output);
      Output.Position := 0;
      image1.MultiResBitmap.LoadItemFromStream(Output,100);

   finally
      Input.Free;
      Output.Free;
   end;

end;

procedure TForm1.Button1Click(Sender: TObject);
var
 img64:TBitmap;
begin
  img64:= ConvertBase64(Memo1.Lines.Text.Trim);
  Image1.Bitmap.Assign(img64);


end;

procedure TForm1.Button2Click(Sender: TObject);
var
  S: String;
  Strm: TMemoryStream;
begin
  S := Memo1.Lines.Text.Trim;
  Strm := TMemoryStream.Create;
  try
    TIdDecoderMIME.DecodeStream(S, Strm);
    Strm.Position := 0;
    Image1.Bitmap.LoadFromStream(Strm);
  finally
    Strm.Free;
  end;
end;




function TForm1.ConvertBase64(str64: string): TBitmap;
var
  S: String;
  Strm: TMemoryStream;
  img:TBitmap;
begin
  S := str64;
  Strm := TMemoryStream.Create;
  try
    TIdDecoderMIME.DecodeStream(S, Strm);
    Strm.Position := 0;
    img:= TBitmap.Create;
    img.CreateFromStream(Strm);

    Result:= img;

    //Image1.Bitmap.LoadFromStream(Strm);
  finally
    Strm.Free;
  end;


end;

end.
