
sub edit-files(*@files, :$editor is copy) is export {
    $editor = $*EDITOR // %*ENV<EDITOR> // 'vim';
}

=begin pod

=head1 NAME

Edit::Files - edit a given set of files

=head1 SYNOPSIS

=begin code :lang<raku>

use Edit::Files;

edit-files(@files, :editor<vim>);

=end code

=head1 DESCRIPTION

Edit::Files attempts to provide an abstract interface to editing a set
of files, with optional line number and column number specifications.

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/Edit-Files .
Comments and Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a
L<small sponsorship|https://github.com/sponsors/lizmat/>  would mean a great
deal to me!

=head1 COPYRIGHT AND LICENSE

Copyright 2022 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
