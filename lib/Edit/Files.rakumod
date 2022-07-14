my sub edit-files(
   *@specs,
  :$editor is copy,
  :$tag,
) is export {
    $editor = $*EDITOR // %*ENV<EDITOR> // 'vim' without $editor;
    with ::('&' ~ $editor) -> &edit {
        edit(@specs, $tag);
    }
    else {
        die "Editor '$editor' is not supported";
    }
}

my sub term:<nano>() { use nqp; nqp::time }

my sub vim(@specs, $tag is copy) {
    $tag = " " without $tag;

    my $tmpfile := $*TMPDIR.add(nano ~ '.vimerr');
    LEAVE $tmpfile.unlink if $tmpfile.e;

    $tmpfile.spurt: @specs.map(-> $spec {
        (Pair.ACCEPTS($spec)
          ?? Pair.ACCEPTS($spec.value)
            ?? "$spec.key():$spec.value.key():$spec.value.value()"
            !! "$spec.key():$spec.value():0"
          !! "$spec:0:0"
        ) ~ ":$tag\n";
    }).join;

    run 'vim', '-q', $tmpfile.absolute;
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

=head1 EXPORTED SUBROUTINES

=head2 edit-files

=begin code :lang<raku>

# edit files "foo" and "bar" with vim
edit-files(<foo bar>, :editor<vim>);

# edit file "foo" at line 42, file "bar" at line 666 with default editor
edit-files( (foo => 42,  bar => 666) );

# edit file "foo" at line 42, column 3 and file "bar" with default editor
edit-files( (foo => 42 => 3,  "bar") );

=end code

The C<edit-files> subroutine slurps the given file specifications and
calls the (implicitely) specified editor to edit these files.

The files can be specified in 3 ways:

=item just as a filename

=item a Pair with filename as key, and line number as value

=item a Pair with filename as key, and a line number => column Pair as value

=head1 SUPPORTED EDITORS

At this writing, only C<vim> is supported.

=head1 ACKNOWLEDGEMENTS

Thanks to Damian Conway for showing the way to handle multiple files / lines
using the compilation error C<-q> feature of C<vim>.

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
