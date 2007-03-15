#
# $Id: sub.pm,v 1.1 2006/10/10 08:00:28 6-o Exp $
#
package Text::HikiDoc::Plugin::sub;

use strict;
use warnings;
use base 'Text::HikiDoc::Plugin';

our $VERSION = sprintf "%d.%03d", q$Revision: 1.1 $ =~ /(\d+)/g;

sub to_html {
    my $self = shift;
    my $str = shift || '';

    return '<sub>'.$str.'</sub>';
}
