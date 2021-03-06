=pod

=head1 PURPOSE

An example of extending Moops to add an C<exception> keyword.

MoopsX::TraitFor::Parser::ExceptionKeyword is a trait for
L<Moops::Parser>, adding support for parsing the C<exception>
keyword, and injects the MoopsX::Keyword::Exception class when
it is encountered.

MoopsX::Keyword::Exception is a simple subclass of
L<Moops::Keyword::Class> and simply adds L<Throwable> to
the list of roles that the class does.

A more practical application of this would be something like an
MVC framework, where you might want to define C<model>, C<view>
and C<controller> keywords, which set up classes with particular
inheritance patterns, and import commonly used functions into
each (e.g. URI manipulation functions into controllers, and HTML
escaping functions into views).

=head1 DEPENDENCIES

Requires the L<Throwable> role which is available from CPAN.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2013 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

use FindBin qw($Bin);
use lib "$Bin/lib";

use Moops traits => [
	'MoopsX::TraitFor::Parser::ExceptionKeyword',
];

exception FileError {
	has filename => (is => 'ro', isa => Str);
}

namespace Demonstration {
	fun go () {
		try {
			FileError->throw(filename => 'not-exists.txt');
		}
		catch {
			say "Caught exception: ", $_->filename;
		};
	}
}

Demonstration::go();
