package Perinci::Sub::To::FuncBase;

use 5.010;
use Data::Dump::OneLine qw(dump1);
use Log::Any '$log';
use Moo;
use Perinci::Object;
use Perinci::ToUtil;

with 'SHARYANTO::Role::Doc::Section';
with 'SHARYANTO::Role::I18N';
with 'SHARYANTO::Role::I18NRinci';

has url => (is=>'rw');
has _pa => (
    is => 'rw',
    lazy => 1,
    default => sub {
        require Perinci::Access;
        require Perinci::Access::Perl;
        my $pa = Perinci::Access->new;
        # slightly reduce startup overhead by avoiding to compile sah schemas
        my $pap = Perinci::Access::Perl->new(
            extra_wrapper_args => {
                validate_args => 0,
            },
        );
        $pa->{handlers}{pl} = $pap;
        delete $pa->{handlers}{''};
        $pa;
    },
); # store Perinci::Access object

# VERSION

sub BUILD {
    my ($self, $args) = @_;

    $self->{doc_sections} //= [
        'summary',
        'description',
        'arguments',
        'result',
        'examples',
        'links',
    ];
}

sub before_gen_doc {
    my ($self, %opts) = @_;

    $self->{url} or die "Please specify url";

    # initialize hash to store [intermediate] result
    $self->{_doc_res} = {};

    # let's retrieve the metadatas first, skip if already provided in _meta
    return if $self->{_doc_meta};

    $log->tracef("=> FuncBase's before_gen_doc(opts=%s)", \%opts);

    my $res = $self->_pa->request(info=>$self->{url});
    $res->[0] == 200 or die "Can't info $self->{url}: $res->[0] - $res->[1]";
    $self->{_doc_info} = $res->[2];
    #$log->tracef("info=%s", $self->{_doc_info});

    die "url must be a function entity, not $self->{_doc_info}{type} ($self->{url})"
        unless $self->{_doc_info}{type} eq 'function';

    $res = $self->_pa->request(meta=>$self->{url});
    if ($res->[0] == 200) {
        $self->{_doc_meta} = $res->[2];
        $self->{_doc_orig_meta} = $res->[3]{orig_meta};
        #$log->tracef("meta=%s", $self->{_doc_meta});
        #$log->tracef("orig_meta=%s", $self->{_doc_orig_meta});
    }
}

# provide simple default implementation without any text wrapping. subclass such
# as Perinci::Sub::To::Text will use another implementation, one that supports
# text wrapping for example (provided by
# SHARYANTO::Role::Doc::Section::AddTextLines).
sub add_doc_lines {
    my $self = shift;
    my $opts;
    if (ref($_[0]) eq 'HASH') { $opts = shift }
    $opts //= {};

    my @lines = map { $_ . (/\n\z/s ? "" : "\n") }
        map {/\n/ ? split /\n/ : $_} @_;

    my $indent = $self->doc_indent_str x $self->doc_indent_level;
    push @{$self->doc_lines},
        map {"$indent$_"} @lines;
}

sub gen_doc_section_summary {
    my ($self) = @_;

    my $name;
    my $summary = "";
    if ($self->{_doc_meta}) {
        $name    = $self->langprop($self->{_doc_meta}, "name");
        $summary = $self->langprop($self->{_doc_fmeta}, "summary");
    }
    $name //= do {
        my $fname = $self->{url};
        $fname =~ s!.+/!!;
        $fname;
    };

    $self->{_doc_res}{name}    = $name;
    $self->{_doc_res}{summary} = $summary;
}

sub gen_doc_section_description {
    my ($self) = @_;

    $self->{_doc_res}{description} = $self->{_doc_meta} ?
        $self->langprop($self->{_doc_meta}, "description") : undef;
}

sub gen_doc_section_arguments {
    my ($self) = @_;
    my $meta  = $self->{_doc_meta};
    my $ometa = $self->{_doc_orig_meta};

    # perl term for args, whether '%args' or '@args' etc
    my $aa = $ometa->{args_as} // $meta->{args_as} // 'hash';
    my $aplt;
    if ($aa eq 'hash') {
        $aplt = '(%args)';
    } elsif ($aa eq 'hashref') {
        $aplt = '(\%args)';
    } elsif ($aa eq 'array') {
        $aplt = '(@args)';
    } elsif ($aa eq 'arrayref') {
        $aplt = '(\@args)';
    } else {
        die "BUG: Unknown value of args_as '$aa'";
    }
    $self->{_doc_res}{args_plterm} = $aplt;

    my $args  = $meta->{args} // {};
    $self->{_doc_res}{args} = {};
    my $raa = $self->{_doc_res}{args};
    for my $name (keys %$args) {
        my $arg = $args->{$name};
        $arg->{default_lang} //= $meta->{default_lang};
        $arg->{schema} //= ['any'=>{}];
        my $s = $arg->{schema};
        my $ra = $raa->{$name} = {schema=>$s};
        $ra->{human_arg} = Perinci::ToUtil::sah2human_short($s);
        if (defined $s->[1]{default}) {
            $ra->{human_arg_default} = dump1($s->[1]{default});
        }
        $ra->{summary}     = $self->langprop($arg, 'summary');
        $ra->{description} = $self->langprop($arg, 'description');
        $ra->{arg}         = $arg;

        $raa->{$name} = $ra;
    }
}

sub gen_doc_section_result {
    my ($self) = @_;

    my $meta  = $self->{_doc_meta};
    my $ometa = $self->{_doc_orig_meta};
    my $res   = $self->{_doc_res};

    $res->{res_schema} = $meta->{result} ? $meta->{result}{schema} : undef;
    $res->{res_schema} //= [any => {}];
    $res->{human_res} = Perinci::ToUtil::sah2human_short($res->{res_schema});

    my $rn = $ometa->{result_naked} // $meta->{result_naked};
    if ($rn) {
        $res->{human_ret} = $res->{human_res};
    } else {
        $res->{human_ret} = '[status, msg, result, meta]';
    }

    $res->{res_summary}     = $self->langprop($meta->{result}, "summary");
    $res->{res_description} = $self->langprop($meta->{result}, "description");
}

sub gen_doc_section_examples {
    # not yet
}

sub gen_doc_section_links {
    # not yet
}

1;
# ABSTRACT: Base class for Perinci::Sub::To::* function documentation generators

=for Pod::Coverage .+
