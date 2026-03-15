unit sodium;

{$mode objfpc}{$H+}

interface

uses
  ctypes;

const
  crypto_aead_xchacha20poly1305_ietf_abytes = 16;
  crypto_pwhash_alg_argon2id13 = 2;

function sodium_init: cint; cdecl; external 'libsodium';

procedure randombytes_buf(buf: pointer; size: csize_t); cdecl; external 'libsodium';

function crypto_pwhash(
  outbuf: pointer;
  outlen: csize_t;
  passwd: pchar;
  passwdlen: csize_t;
  salt: pointer;
  opslimit: uint64;
  memlimit: size_t;
  alg: cint
): cint; cdecl; external 'libsodium';

function crypto_aead_xchacha20poly1305_ietf_encrypt(
  c: pointer;
  clen: puint64;
  m: pointer;
  mlen: uint64;
  ad: pointer;
  adlen: uint64;
  nsec: pointer;
  npub: pointer;
  k: pointer
): cint; cdecl; external 'libsodium';

function crypto_aead_xchacha20poly1305_ietf_decrypt(
  m: pointer;
  mlen: puint64;
  nsec: pointer;
  c: pointer;
  clen: uint64;
  ad: pointer;
  adlen: uint64;
  npub: pointer;
  k: pointer
): cint; cdecl; external 'libsodium';

implementation

initialization
  sodium_init;

end.
