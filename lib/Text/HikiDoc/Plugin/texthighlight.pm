#
# $Id: texthighlight.pm,v 1.5 2007/02/17 05:00:19 oneroad Exp $
#
package Text::HikiDoc::Plugin::texthighlight;

use strict;
use warnings;
no warnings 'redefine';

our $VERSION = sprintf "%d.%03d", q$Revision: 1.5 $ =~ /(\d+)/g;

use Text::Highlight;

*Text::HikiDoc::_parse_pre = sub {
    my $self = shift;
    my $string = shift || '';

    my $MULTI_PRE_OPEN_RE  = '&lt;&lt;&lt;';
    my $MULTI_PRE_CLOSE_RE = '&gt;&gt;&gt;';
    my $PRE_RE = "^[ \t]";

    my $c = sub {
        my $str = shift;
        my $type = shift || 'Perl';
        # CPP, CSS, HTML, Java, PHP, Perl, SQL
        return if $str eq '';

        $type = uc $type;
        $type = 'Java' if ( $type eq 'JAVA' );
        $type = 'Perl' if ( $type eq 'PERL' );

        my $th = Text::Highlight->new(wrapper => "%s");
        return $th->highlight($type,$str);
    };

    $string =~ s|^$MULTI_PRE_OPEN_RE$(.*?)^$MULTI_PRE_CLOSE_RE$|"\n".$self->_store_block('<pre>'.$self->_restore_pre($1).'</pre>')."\n\n"|esgm;
    $string =~ s|^$MULTI_PRE_OPEN_RE[ \t]*[aA]{2}$(.*?)^$MULTI_PRE_CLOSE_RE$|"\n".$self->_store_block('<pre class="ascii-art">'.$1.'</pre>')."\n\n"|esgm;
    $string =~ s|^$MULTI_PRE_OPEN_RE[ \t]*(\w*)$(.*?)^$MULTI_PRE_CLOSE_RE$|"\n".$self->_store_block('<pre class="texthighlight">'.$self->_restore_pre($c->($2,$1)).'</pre>')."\n\n"|esgm;
    $c = undef;

    return $string;
};

1;
