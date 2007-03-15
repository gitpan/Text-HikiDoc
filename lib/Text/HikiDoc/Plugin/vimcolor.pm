#
# $Id: vimcolor.pm,v 1.5 2007/02/17 05:00:00 oneroad Exp $
#
package Text::HikiDoc::Plugin::vimcolor;

use strict;
use warnings;
no warnings 'redefine';

our $VERSION = sprintf "%d.%03d", q$Revision: 1.5 $ =~ /(\d+)/g;

use Text::VimColor;

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

        $type = lc $type;
        my $th = Text::VimColor->new(
                                     string => $str,
                                     filetype => $type,
                                    );
        return $th->html();
    };

    $string =~ s|^$MULTI_PRE_OPEN_RE$(.*?)^$MULTI_PRE_CLOSE_RE$|"\n".$self->_store_block('<pre>'.$self->_restore_pre($1).'</pre>')."\n\n"|esgm;
    $string =~ s|^$MULTI_PRE_OPEN_RE[ \t]*[aA]{2}$(.*?)^$MULTI_PRE_CLOSE_RE$|"\n".$self->_store_block('<pre class="ascii-art">'.$1.'</pre>')."\n\n"|esgm;
    $string =~ s|^$MULTI_PRE_OPEN_RE[ \t]*(\w*)$(.*?)^$MULTI_PRE_CLOSE_RE$|"\n".$self->_store_block('<pre class="vimcolor">'.$self->_restore_pre($c->($2,$1)).'</pre>')."\n\n"|esgm;
    $c = undef;

    return $string;
};

1;
