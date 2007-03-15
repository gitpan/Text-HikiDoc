#
# $Id: br.pm,v 1.3 2006/11/12 09:38:50 6-o Exp $
#
package Text::HikiDoc::Plugin::br;

use strict;
use warnings;
use base 'Text::HikiDoc::Plugin';

our $VERSION = sprintf "%d.%03d", q$Revision: 1.3 $ =~ /(\d+)/g;

sub to_html {
    my $self = shift;
    my $num = shift || 1;

    my $ret = '<br';
    $ret .= $self->{empty_element_suffix} || ' />';

    return $ret x $num;
}
