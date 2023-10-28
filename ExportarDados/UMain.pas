unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Samples.Gauges, Vcl.StdCtrls,
  Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmMain = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Button2: TButton;
    Button1: TButton;
    EdtLinhas: TEdit;
    Memo1: TMemo;
    Gauge1: TGauge;
    FDConnection1: TFDConnection;
    QryItens: TFDQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;
  stop : Boolean;
implementation

{$R *.dfm}

procedure TFrmMain.Button1Click(Sender: TObject);
var
  RegistrosPorPagina,
  RegistrosQuebrados,
  RegistrosPercorridos,
  TotalRegistros,
  Paginas,
  I, Contador : integer;
  arq : TextFile;
begin
  Memo1.Lines.Clear;

  RegistrosPorPagina := Strtoint(EdtLinhas.Text);
  FDConnection1.FetchOptions.RowsetSize := RegistrosPorPagina;

  QryItens.Close;
  QryItens.SQL.Clear;
  QryItens.SQL.Add('Select Count(ENDERECO_CEP) registros From ENDERECO ');
  QryItens.Open();


  TotalRegistros:= QryItens.FieldByName('registros').AsInteger;

  Memo1.Lines.Add('================================================');
  Memo1.Lines.Add('Total de Registros : '+ TotalRegistros.ToString );
  Memo1.Lines.Add('================================================');


  Paginas := TotalRegistros div RegistrosPorPagina;
  RegistrosQuebrados := TotalRegistros - (Paginas * RegistrosPorPagina);

  if RegistrosQuebrados > 0 then
     inc(Paginas);

  Memo1.Lines.Add('================================================');
  Memo1.Lines.Add('Total de Páginas : '+ Paginas.ToString );
  Memo1.Lines.Add('================================================');

  Memo1.Lines.Add('================================================');
  Memo1.Lines.Add('Registros por Página : '+ RegistrosPorPagina.ToString );
  Memo1.Lines.Add('================================================');

  Memo1.Lines.Add('================================================');
  Memo1.Lines.Add('Registros Quebrados : '+ RegistrosQuebrados.ToString );
  Memo1.Lines.Add('================================================');

  RegistrosPercorridos := 0;

  Gauge1.MaxValue := Paginas;
  Gauge1.Progress := 0;

  stop := False;

  AssignFile(arq, 'C:\itens.txt');
  Rewrite(arq);
  Contador := 0;

  for I := 1 to Paginas do
  begin
    Gauge1.Progress := Gauge1.Progress + 1;
    Application.ProcessMessages;

    QryItens.Close;
    QryItens.SQL.Clear;
    QryItens.SQL.Add('select first '+ RegistrosPorPagina.ToString +' skip :p ');
    QryItens.SQL.Add('BAIRRO_CODIGO , ENDERECO_CODIGO, ENDERECO_CEP, ENDERECO_LOGRADOURO  ');
    QryItens.SQL.Add('from ENDERECO order by ENDERECO_CEP ');

    QryItens.ParamByName('p').AsInteger := RegistrosPercorridos;
    QryItens.Open;
    QryItens.first;

    while not QryItens.eof do
    begin
      inc(Contador);
      Application.ProcessMessages;
      Writeln(arq, QryItens.FieldByName('BAIRRO_CODIGO').asstring   , '|' ,
                   QryItens.FieldByName('ENDERECO_CODIGO').asstring , '|' ,
                   QryItens.FieldByName('ENDERECO_CEP').asstring    , '|' ,
                   QryItens.FieldByName('ENDERECO_LOGRADOURO').asstring
             );
      QryItens.Next;
    end;

    Memo1.Lines.Add('================================================');
    Memo1.Lines.Add('Página : '+ I.ToString + ' A partir Registros : '+ RegistrosPercorridos.ToString );
    Memo1.Lines.Add('================================================');

    RegistrosPercorridos := RegistrosPercorridos + RegistrosPorPagina;

    if Stop then
       break ;

  end;
  Memo1.Lines.Add('Final do processo. total :' + Contador.ToString);
  ShowMessage('Final do processo. total :' + Contador.ToString);
  CloseFile(arq);

end;

procedure TFrmMain.Button2Click(Sender: TObject);
begin
  stop :=True;
end;

end.





















//    Memo1.Lines.Add(QryItens.FieldByName('ENDERECO_CEP').asstring  + ' - ' +
//                    QryItens.FieldByName('ENDERECO_LOGRADOURO').asstring);

