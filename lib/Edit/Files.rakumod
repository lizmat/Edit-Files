my sub edit-files(
   *@specs,
  :$editor is copy,
  :$tag,
) is export {
    $editor  = $*EDITOR // %*ENV<EDITOR> // 'vim' without $editor;

    if Callable.ACCEPTS($editor) {
        $editor(@specs, $tag) if @specs;
    }
    orwith ::('&' ~ $editor) -> &edit {
        edit(@specs, $tag) if @specs;
    }
    else {
        die "Editor '$editor' is not supported";
    }
}

my sub vi(  @specs, $tag) { vim @specs, $tag, 'vi'   }
my sub view(@specs, $tag) { vim @specs, $tag, 'view' }
my sub nvim(@specs, $tag) { vim @specs, $tag, 'nvim' }

my sub vim(@specs, $tag is copy, $editor = 'vim') {
    $tag = " " without $tag;

    my $tmpfile := do {
        use nqp;
        $*TMPDIR.add(nqp::time() ~ '.vim-q')
    }
    LEAVE $tmpfile.unlink if $tmpfile.e;

    $tmpfile.spurt: @specs.map(-> $spec {
        (Pair.ACCEPTS($spec)
          ?? Pair.ACCEPTS($spec.value)
            ?? "$spec.key():$spec.value.key():$spec.value.value()"
            !! "$spec.key():$spec.value():0"
          !! "$spec:0:0"
        ) ~ ":$tag\n";
    }).join;

    run $editor, '-q', $tmpfile.absolute;
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

The following additional optional named arguments can be specified:

=head3 :editor

Specifies the editor to be used.  Defaults to the contents of C<$*EDITOR> or
C<%*ENV<EDITOR>> or 'vim'.

=head3 :tag

An optional tag to be added to each location specified.  Defaults to C<" ">
(aka a space).

=head1 SUPPORTED EDITORS

These editors are currently supported:

=item vi
=item vim
=item view
=item nvim

=head1 SUPPORTING YOUR OWN EDITOR

=begin code :lang<raku>

use Edit::Files;

my sub feditor(@specs, $tag) {
    # handle specs
    run 'feditor', ...
}

edit-files <foo bar>, :editor(&feditor); # edit "foo" and "bar" with "feditor"

=end code

You can add your own editor to the list of editors supported by
C<Edit::Files> by creating a C<sub> that accepts an array with
file / line / column specifications and a tag to be applied.
Then you can specify that subroutine in the C<:editor> argument
to C<edit-files>.

=head1 ADDING AN EDITOR TO THIS DISTRIBUTION

Create a C<sub> as described above, and create a
L<Pull Request|https://github.com/lizmat/Edit-Files/pulls> to have that
subroutine added to this distribution.

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
