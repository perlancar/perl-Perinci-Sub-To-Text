package Perinci::Sub::To::Text::I18N::fr;
use parent qw(Perinci::Sub::To::Text::I18N Perinci::Sub::To::FuncBase::I18N::fr);

use Locale::Maketext::Lexicon::Gettext;
our %Lexicon = %{ Locale::Maketext::Lexicon::Gettext->parse(<DATA>) };

# VERSION

#use Data::Dump; dd \%Lexicon;

1;
# ABSTRACT: French translation for Perinci::To::Text
__DATA__
msgid  ""
msgstr ""