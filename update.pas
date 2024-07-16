unit update;

interface

uses
  IdURI, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkinLiquidSky, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinSilver, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinVS2010, dxSkinWhiteprint, IdGlobal,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP, Vcl.StdCtrls, cxButtons, cxControls,
  cxContainer, cxEdit, cxLabel, cxProgressBar, Vcl.ComCtrls, ShellApi,
  dxSkinOffice2016Colorful, dxSkinOffice2016Dark, dxSkinTheBezier,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light;

type
  Tfrm_main = class(TForm)
    btUpdate: TButton;
    ftp: TIdFTP;
    pLoading: TProgressBar;
    label6: TLabel;
    Button1: TButton;
    edURL: TEdit;
    lbUrl: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btUpdateClick(Sender: TObject);
    procedure ftpWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure ftpWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure ftpWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
  private
    { Private declarations }
  public
var wpath, NamaFile :string;
    WorkMax: Int64;
    { Public declarations }
  end;

var
  frm_main: Tfrm_main;

implementation

{$R *.dfm}

procedure Tfrm_main.btUpdateClick(Sender: TObject);
begin
  wpath:=ExtractFilePath(Application.ExeName);
  NamaFile:='rsyasminx.exe';

  //delete
  if DeleteFile(wpath + NamaFile) then
//  ShowMessage('Berhasil menghapus file'+ NamaFile) ;

  //rename
  if RenameFile(wpath+'rsyasmin.exe', wpath + NamaFile) then
//  ShowMessage('RENAME BERHASIL');

  //download dari ftp
  ftp.Get('rsyasmin.exe','rsyasmin.exe',true);
  ftp.Quit;
  ftp.Disconnect;

  ShowMessage('SUKSES!!');

  ShellExecute(handle, 'open', PChar(ExtractFilePath(Application.ExeName)+'rsyasmin.exe'),'','',SW_NORMAL);
  Close;
end;

procedure Tfrm_main.FormCreate(Sender: TObject);
var  URL: string;
  Uri: TIdURI;
begin
  URL := edURL.Text;
  Uri := TIdURI.Create(URL);
  try
    ftp.Host := Uri.Host;
    //if Uri.Port <> '' then
      //ftp.Port := IntToStr(Uri.Port)
    //else
    ftp.Port := 21;
    ftp.Username := 'simrs';//Uri.Username;
    ftp.Password := 'emergency1';//Uri.Password;
    ftp.ConnectTimeout := 5000;
    ftp.Connect;
    if Uri.Path <> '/' then
      ftp.ChangeDir(Uri.Path);
  finally
    Uri.Free;
  end;
end;

procedure Tfrm_main.ftpWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin


  if WorkMax > 0 then
  begin
    pLoading.Position := (AWorkCount * 100) div WorkMax;
    Label6.Caption := IntToStr(AWorkCount) + ' bytes';
    //Label6.Caption := IntToStr(pLoading.Position) + '%';
  end else
    Label6.Caption := IntToStr(AWorkCount) + ' bytes';
  Update;


end;

procedure Tfrm_main.ftpWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  if AWorkMode = wmWrite then
    WorkMax := AWorkCountMax
  else;
    WorkMax := 50; // value retrieved beforehand...
  pLoading.Min := 0;
  pLoading.Max := 100;
  pLoading.Position := 0;
end;

procedure Tfrm_main.ftpWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  pLoading.Position := 0;
end;

end.
