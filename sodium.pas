unit sodium;

{$mode objfpc}{$H+}

interface

uses
  ctypes;

const
  crypto_aead_xchacha20poly1305_ietf_abytes = 16;
  crypto_pwhash_alg_argon2id13 = 2;

var
  sodium_init: function: cint; cdecl;
  randombytes_buf: procedure(buf: pointer; size: csize_t); cdecl;

  crypto_pwhash: function(
    outbuf: pointer;
    outlen: csize_t;
    passwd: pchar;
    passwdlen: csize_t;
    salt: pointer;
    opslimit: uint64;
    memlimit: csize_t;
    alg: cint
  ): cint; cdecl;

  crypto_aead_xchacha20poly1305_ietf_encrypt: function(
    c: pointer;
    clen: puint64;
    m: pointer;
    mlen: uint64;
    ad: pointer;
    adlen: uint64;
    nsec: pointer;
    npub: pointer;
    k: pointer
  ): cint; cdecl;

  crypto_aead_xchacha20poly1305_ietf_decrypt: function(
    m: pointer;
    mlen: puint64;
    nsec: pointer;
    c: pointer;
    clen: uint64;
    ad: pointer;
    adlen: uint64;
    npub: pointer;
    k: pointer
  ): cint; cdecl;

implementation

uses
  Classes, SysUtils
  {$IFDEF WINDOWS}
  , Windows, MemoryModule
  {$ENDIF}
  {$IFDEF UNIX}
  , dynlibs
  {$ENDIF}
  ;

{$IFDEF WINDOWS}
var
  LibHandle: TMemoryModule = nil;

procedure LoadProc(var P: Pointer; const Name: PChar);
begin
  P := MemoryGetProcAddress(LibHandle, PAnsiChar(Name));
  if P = nil then
    raise Exception.Create('libsodium: Funktion nicht gefunden: ' + Name);
end;

procedure InitSodium;
var
  RS: TResourceStream;
begin
  // libsodium.dll steckt als Ressource im Exe und wird direkt aus dem
  // Speicher geladen, ohne sie vorher auf die Platte zu schreiben.
  RS := TResourceStream.Create(HInstance, 'LIBSODIUM', RT_RCDATA);
  try
    LibHandle := MemoryLoadLibary(RS.Memory);
  finally
    RS.Free;
  end;

  if LibHandle = nil then
    raise Exception.Create('libsodium.dll konnte nicht geladen werden');

  // Funktionen binden
  LoadProc(Pointer(sodium_init), 'sodium_init');
  LoadProc(Pointer(randombytes_buf), 'randombytes_buf');
  LoadProc(Pointer(crypto_pwhash), 'crypto_pwhash');
  LoadProc(Pointer(crypto_aead_xchacha20poly1305_ietf_encrypt),
    'crypto_aead_xchacha20poly1305_ietf_encrypt');
  LoadProc(Pointer(crypto_aead_xchacha20poly1305_ietf_decrypt),
    'crypto_aead_xchacha20poly1305_ietf_decrypt');

  // Initialisieren
  if sodium_init() < 0 then
    raise Exception.Create('libsodium Initialisierung fehlgeschlagen');
end;

procedure CleanupSodium;
begin
  if LibHandle <> nil then
  begin
    MemoryFreeLibrary(LibHandle);
    LibHandle := nil;
  end;
end;
{$ENDIF}

{$IFDEF UNIX}
const
  // Unter Linux wird keine eigene libsodium mitgeliefert, sondern die vom
  // System bereitgestellte (Paket libsodium23 bzw. libsodium-dev) über den
  // SONAME dynamisch nachgeladen.
  SODIUM_SONAMES: array[0..2] of string = (
    'libsodium.so.23',
    'libsodium.so.26',
    'libsodium.so'
  );

var
  LibHandle: TLibHandle = NilHandle;

procedure LoadProc(var P: Pointer; const Name: string);
begin
  P := GetProcedureAddress(LibHandle, Name);
  if P = nil then
    raise Exception.Create('libsodium: Funktion nicht gefunden: ' + Name);
end;

procedure InitSodium;
var
  I: Integer;
begin
  for I := Low(SODIUM_SONAMES) to High(SODIUM_SONAMES) do
  begin
    LibHandle := LoadLibrary(SODIUM_SONAMES[I]);
    if LibHandle <> NilHandle then
      Break;
  end;

  if LibHandle = NilHandle then
    raise Exception.Create(
      'libsodium konnte nicht geladen werden (ist das Paket libsodium23 installiert?)');

  // Funktionen binden
  LoadProc(Pointer(sodium_init), 'sodium_init');
  LoadProc(Pointer(randombytes_buf), 'randombytes_buf');
  LoadProc(Pointer(crypto_pwhash), 'crypto_pwhash');
  LoadProc(Pointer(crypto_aead_xchacha20poly1305_ietf_encrypt),
    'crypto_aead_xchacha20poly1305_ietf_encrypt');
  LoadProc(Pointer(crypto_aead_xchacha20poly1305_ietf_decrypt),
    'crypto_aead_xchacha20poly1305_ietf_decrypt');

  // Initialisieren
  if sodium_init() < 0 then
    raise Exception.Create('libsodium Initialisierung fehlgeschlagen');
end;

procedure CleanupSodium;
begin
  if LibHandle <> NilHandle then
  begin
    UnloadLibrary(LibHandle);
    LibHandle := NilHandle;
  end;
end;
{$ENDIF}

initialization
  InitSodium;

finalization
  CleanupSodium;

end.
