package Perinci::Sub::To::FuncBase::I18N::fr;
use base 'Perinci::Sub::To::FuncBase::I18N';

use Locale::Maketext::Lexicon::Gettext;
our %Lexicon = %{ Locale::Maketext::Lexicon::Gettext->parse(<DATA>) };

# VERSION

#use Data::Dump; dd \%Lexicon;

1;
# ABSTRACT: French translation for Perinci::To::PackageBase
__DATA__
# tmp: Sah

msgid  "default"
msgstr "défaut"

# function

msgid  "Arguments"
msgstr "Arguments"

msgid  "General arguments"
msgstr "Arguments généraux"

msgid  "Arguments related to '%1'"
msgstr "Arguments liés à la '%1'"

msgid  "'*' denotes required arguments"
msgstr "'*' désigne arguments nécessaires"

msgid  "Special arguments"
msgstr "Arguments spéciaux"

msgid  "Result"
msgstr "Résultat"

msgid  "Return value"
msgstr "Valeur de retour"

msgid  "Returns an enveloped result (an array). First element (status) is an integer containing HTTP status code (200 means OK, 4xx caller error, 5xx function error). Second element (msg) is a string containing error message, or 'OK' if status is 200. Third element (result) is optional, the actual result. Fourth element (meta) is called result metadata and is optional, a hash that contains extra information."
msgstr "Retourner un résultat enveloppé (un tableau). Premier élément (status) est un entier contenant le code d'état HTTP (200 moyens OK, erreur de l'appelant 4xx, erreur de fonction 5xx). Second élément (msg) est un message d'erreur contenant des cordes, ou 'OK' si l'état est de 200. Troisième élément (résultat) est facultative, le résultat réel. Quatrième élément (méta) est appelée méta-données du résultat et est facultatif, un hachage qui contient des informations supplémentaires."

# function features

# OLD
#msgid  "This function supports undo operation. Please read 'The undo protocol' in Rinci::function specification."
#msgstr ""

# OLD
#msgid  "This function is declared as %1 (%2). Please read the '%1' feature in Rinci::function specification."
#msgid  ""

msgid  "This function supports reverse operation."
msgstr "Cette fonction permet l'opération inverse."

msgid  "This function supports undo operation."
msgstr "Cette fonction permet l'opération d'annulation."

msgid  "This function supports dry-run operation."
msgstr "Cette fonction permet l'opération en mode simulation (dry-run)."

msgid  "This function is pure (produce no side effects)."
msgstr "Cette fonction est pure (produire aucun effet secondaire)."

msgid  "This function is immutable (returns same result for same arguments)."
msgstr "Cette fonction est immuable (retourner même résultat pour mêmes arguments)."

msgid  "This function is idempotent (repeated invocations with same arguments has the same effect as single invocation)."
msgstr "Cette fonction est idempotent (invocations répétées ayant les mêmes arguments ont le même effet que seule invocation)."

msgid  "This function requires transactions."
msgstr "Cette fonction nécessite transactions."

msgid  "This function can use transactions."
msgstr "Cette fonction peut utiliser les transactions."

msgid  "This function can start a new transaction."
msgstr "Cette fonction peut commencer une nouvelle transaction."

msgid  "This function can end (commit) transactions."
msgstr "Cette fonction peut se terminer (commit) transactions."

# test multiline

msgid  ""
"Line 1"
"Line 2"
msgstr ""
"Ligne 1"
"Ligne 2"

msgid  "This function dies on error."
msgstr "Cette fonction meurt en cas d'erreur."
