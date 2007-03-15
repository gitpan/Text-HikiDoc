#
# $Id: ins.pm,v 1.1 2006/10/10 08:00:20 6-o Exp $
#
package Text::HikiDoc::Plugin::ins;

use strict;
use warnings;
use base 'Text::HikiDoc::Plugin';

our $VERSION = sprintf "%d.%03d", q$Revision: 1.1 $ =~ /(\d+)/g;

sub to_html {
    my $self = shift;
    my $str = @_ ? join("\n",@_) : '';

    $str =~ s/\n/<br$self->{empty_element_suffix}\n/g if ($self->{br_mode} eq 'true');

    return '<ins>'.$str.'</ins>';
}
