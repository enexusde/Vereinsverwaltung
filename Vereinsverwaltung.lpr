program Vereinsverwaltung;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  SysUtils,
  Forms, vereinswindowmain, beitragssatzaenderung, CryptoUnit, sodium
  {$IFDEF WINDOWS}
  , MemoryModule
  {$ENDIF}
  { you can add units after this };

{$R *.res}

begin
  // Zahlen- und Datumsformat unabhaengig von der Locale des Betriebssystems
  // festlegen, da die App durchgaengig deutsche Formatierung (Komma als
  // Dezimaltrennzeichen, dd.mm.yyyy) erwartet.
  DefaultFormatSettings.DecimalSeparator := ',';
  DefaultFormatSettings.ThousandSeparator := '.';
  DefaultFormatSettings.DateSeparator := '.';
  DefaultFormatSettings.ShortDateFormat := 'dd.mm.yyyy';

  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  {$PUSH}{$WARN 5044 OFF}
  Application.MainFormOnTaskbar:=True;
  {$POP}
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TMembershipChangeForm, MembershipChangeForm);
  Application.Run;
end.

