package Perinci::To::PackageBase::I18N::id;
use base 'Perinci::To::PackageBase::I18N';

use Locale::Maketext::Lexicon::Gettext;
our %Lexicon = %{ Locale::Maketext::Lexicon::Gettext->parse(<DATA>) };

# VERSION

#use Data::Dump; dd \%Lexicon;

1;
# ABSTRACT: Indonesian translation for Perinci::To::PackageBase
__DATA__
# tmp: Sah

msgid  "default"
msgstr "bawaan"

# function

msgid  "Arguments"
msgstr "Argumen"

msgid  "General arguments"
msgstr "Argumen umum"

msgid  "Arguments related to '%1'"
msgstr "Argumen yang berkaitan dengan '%1'"

msgid  "'*' denotes required arguments"
msgstr "'*' menandakan argumen wajib"

msgid  "Special arguments"
msgstr "Argumen khusus"

msgid  "Result"
msgstr "Hasil"

msgid  "Return value"
msgstr "Nilai kembali"

msgid  "Returns an enveloped result (an array). First element (status) is an integer containing HTTP status code (200 means OK, 4xx caller error, 5xx function error). Second element (msg) is a string containing error message, or 'OK' if status is 200. Third element (result) is optional, the actual result. Fourth element (meta) is called result metadata and is optional, a hash that contains extra information."
msgstr "Mengembalikan hasil terbungkus (larik). Elemen pertama (status) adalah bilangan bulat berisi kode status HTTP (200 berarti OK, 4xx kesalahan di pemanggil, 5xx kesalahan di fungsi). Elemen kedua (msg) adalah string berisi pesan kesalahan, atau 'OK' jika status 200. Elemen ketiga (result) bersifat opsional, berisi hasil yang diinginkan. Elemen keempat (meta) disebut metadata hasil, bersifat opsional, berupa hash informasi tambahan."

# function features

# OLD
#msgid  "This function supports undo operation. Please read 'The undo protocol' in Rinci::function specification."
#msgstr "Fungsi ini mendukung operasi undo (pembatalan). Silakan baca 'The undo protocol' di spesifikasi Rinci::function."

# OLD
#msgid  "This function is declared as %1 (%2). Please read the '%1' feature in Rinci::function specification."
#msgid  "Fungsi ini dideklarasikan %1 (%2). Silakan baca fitur '%1' di spesifikasi Rinci::function."

msgid  "This function supports reverse operation."
msgstr "Fungsi ini mendukung operasi reverse."

msgid  "This function supports undo operation."
msgstr "Fungsi ini mendukung operasi undo."

msgid  "This function supports dry-run operation."
msgstr "Fungsi ini mendukung mode simulasi (dry-run)."

msgid  "This function is pure (produce no side effects)."
msgstr "Fungsi ini murni (pure, tidak menghasilkan efek samping)."

msgid  "This function is immutable (returns same result for same arguments)."
msgstr "Fungsi ini bersifat imutabel (immutable, mengembalikan hasil yang sama untuk argumen yang sama)."

msgid  "This function is idempotent (repeated invocations with same arguments has the same effect as single invocation)."
msgstr "Fungsi ini bersifat idempoten (idempotent, pemanggilan berulang kali dengan argumen yang sama efeknya seperti pemanggilan sekali)."

msgid  "This function requires transactions."
msgstr "Fungsi ini membutuhkan transaksi."

msgid  "This function can use transactions."
msgstr "Fungsi ini dapat memakai transaksi."

msgid  "This function can start a new transaction."
msgstr "Fungsi ini dapat memulai transaksi baru."

msgid  "This function can end (commit) transactions."
msgstr "Fungsi ini dapat mengakhiri (commit) transaksi."

# test multiline

msgid  ""
"Line 1"
"Line 2"
msgstr ""
"Baris 1"
"Baris 2"

msgid  "This function dies on error."
msgstr "Fungsi ini die() jika menemui kesalahan."
