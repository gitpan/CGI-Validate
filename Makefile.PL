use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
	NAME			=> 'CGI::Validate',
	VERSION_FROM	=> 'Validate.pm', # finds $VERSION
	PREREQ_PM		=> {
		CGI			=> 0,
		Carp		=> 0,
	},
);
