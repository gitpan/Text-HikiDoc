use strict;
use warnings;
use inc::Module::Install;
use Module::Build;

my $class = Module::Build
	->subclass(
		class => 'NonmoduleBuilder',
		code => q{
				sub ACTION_docs {}; # don't make blib/libdoc
				sub ACTION_distmeta { # don't make META.yml
					$_[0]->{metafile} = 'MANIFEST';
				};
				sub ACTION_manifest { # don't add META.yml to MANIFEST
					$_[0]->{metafile} = 'MANIFEST';
					$_[0]->SUPER::ACTION_manifest(@_);
				};
			},
	);

$class->new(
	module_name => 'Text::HikiDoc',
	license => 'perl',
#	dist_author => 'Kawabata, Kazumichi (Higemaru) E<lt>oneroad@mac.comE<gt>',
	create_readme => 1,
	create_makefile_pl => 'small',
    requires => {
        'perl' => '5.6.0',
        'File::Basename' => 0,
    },
)->create_build_script;
