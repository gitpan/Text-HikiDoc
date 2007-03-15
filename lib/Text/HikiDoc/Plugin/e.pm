#
# $Id: e.pm,v 1.1 2006/10/10 05:39:57 6-o Exp $
#
package Text::HikiDoc::Plugin::e;

use strict;
use warnings;
use base 'Text::HikiDoc::Plugin';

our $VERSION = sprintf "%d.%03d", q$Revision: 1.1 $ =~ /(\d+)/g;

sub to_html {
    my $self = shift;
    my $str = shift || '';

    if ( $str =~ /^(\d+)$/ ) {
        $str = '&#'.$str.';';
    }
    else {
        $str = '&'.$str.';';
    }

    return $str;
}
