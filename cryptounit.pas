unit CryptoUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

procedure EncryptStreamToFile(Stream: TStream; const FileName, Password: string);
procedure DecryptFileToStream(const FileName, Password: string; Stream: TStream);

implementation

uses
  sodium;

const
  SALT_SIZE = 32;
  NONCE_SIZE = 24;
  KEY_SIZE = 32;

  ARGON_MEM = 512 * 1024; // 512MB
  ARGON_ITER = 4;

procedure DeriveKey(const Password: string; const Salt; var Key);
begin
  crypto_pwhash(
    @Key,
    KEY_SIZE,
    PChar(Password),
    Length(Password),
    @Salt,
    ARGON_ITER,
    ARGON_MEM * 1024,
    crypto_pwhash_alg_argon2id13
  );
end;

procedure EncryptStreamToFile(Stream: TStream; const FileName, Password: string);
var
  Salt: array[0..SALT_SIZE-1] of byte;
  Nonce: array[0..NONCE_SIZE-1] of byte;
  Key: array[0..KEY_SIZE-1] of byte;

  Plain: array of byte;
  Cipher: array of byte;

  CipherLen: UInt64;
  F: TFileStream;
begin
  SetLength(Plain, Stream.Size);
  Stream.Position := 0;
  Stream.ReadBuffer(Plain[0], Length(Plain));

  randombytes_buf(@Salt, SALT_SIZE);
  randombytes_buf(@Nonce, NONCE_SIZE);

  DeriveKey(Password, Salt, Key);

  SetLength(Cipher, Length(Plain) + crypto_aead_xchacha20poly1305_ietf_abytes);

  crypto_aead_xchacha20poly1305_ietf_encrypt(
    @Cipher[0],
    @CipherLen,
    @Plain[0],
    Length(Plain),
    nil,
    0,
    nil,
    @Nonce,
    @Key
  );

  F := TFileStream.Create(FileName, fmCreate);
  try
    F.WriteBuffer(Salt, SALT_SIZE);
    F.WriteBuffer(Nonce, NONCE_SIZE);
    F.WriteBuffer(Cipher[0], CipherLen);
  finally
    F.Free;
  end;
end;

procedure DecryptFileToStream(const FileName, Password: string; Stream: TStream);
var
  F: TFileStream;

  Salt: array[0..SALT_SIZE-1] of byte;
  Nonce: array[0..NONCE_SIZE-1] of byte;
  Key: array[0..KEY_SIZE-1] of byte;

  Cipher: array of byte;
  Plain: array of byte;

  CipherLen: Int64;
  PlainLen: UInt64;
begin
  F := TFileStream.Create(FileName, fmOpenRead);
  try
    F.ReadBuffer(Salt, SALT_SIZE);
    F.ReadBuffer(Nonce, NONCE_SIZE);

    CipherLen := F.Size - SALT_SIZE - NONCE_SIZE;

    SetLength(Cipher, CipherLen);
    F.ReadBuffer(Cipher[0], CipherLen);

    DeriveKey(Password, Salt, Key);

    SetLength(Plain, CipherLen);

    if crypto_aead_xchacha20poly1305_ietf_decrypt(
      @Plain[0],
      @PlainLen,
      nil,
      @Cipher[0],
      CipherLen,
      nil,
      0,
      @Nonce,
      @Key
    ) <> 0 then
      raise Exception.Create('Wrong password or corrupted file');

    Stream.WriteBuffer(Plain[0], PlainLen);
    Stream.Position := 0;

  finally
    F.Free;
  end;
end;

end.
