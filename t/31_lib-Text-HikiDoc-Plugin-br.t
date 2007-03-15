# $Id: 31_lib-Text-HikiDoc-Plugin-br.t,v 1.3 2006/10/13 04:09:33 6-o Exp $
use Test::Base;
use Text::HikiDoc;

plan tests => 1 * blocks;
filters { outline => 'chomp' };

my $obj = Text::HikiDoc->new;
$obj->enable_plugin('br');
run {
    my $block = shift;
    is $obj->to_html($block->input), $block->output, $block->outline;
}

__END__
===
--- input
hogehoge{{br}}fugafuga
--- output
<p>hogehoge<br />fugafuga</p>
--- outline
{{br}}

===
--- input
hogehoge{{br(3)}}fugafuga
--- output
<p>hogehoge<br /><br /><br />fugafuga</p>
--- outline
{{br(3)}}

===
--- input
hogehoge{{br '2'}}fugafuga
--- output
<p>hogehoge<br /><br />fugafuga</p>
--- outline
{{br '2'}}

===
--- input
hogehoge{{br
"4"
}}fugafuga
--- output
<p>hogehoge<br /><br /><br /><br />fugafuga</p>
--- outline
{{br\n"4"}}

===
--- input lines chomp
hogehoge{{br}}fugafuga
1
>
--- output
<p>hogehoge<br>fugafuga</p>
--- outline
{{br}} with empty_element_suffix
