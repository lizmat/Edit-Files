[![Actions Status](https://github.com/lizmat/Edit-Files/actions/workflows/test.yml/badge.svg)](https://github.com/lizmat/Edit-Files/actions)

NAME
====

Edit::Files - edit a given set of files

SYNOPSIS
========

```raku
use Edit::Files;

edit-files(@files, :editor<vim>);
```

DESCRIPTION
===========

Edit::Files attempts to provide an abstract interface to editing a set of files, with optional line number and column number specifications.

EXPORTED SUBROUTINES
====================

edit-files
----------

```raku
# edit files "foo" and "bar" with vim
edit-files(<foo bar>, :editor<vim>);

# edit file "foo" at line 42, file "bar" at line 666 with default editor
edit-files( (foo => 42,  bar => 666) );

# edit file "foo" at line 42, column 3 and file "bar" with default editor
edit-files( (foo => 42 => 3,  "bar") );
```

The `edit-files` subroutine slurps the given file specifications and calls the (implicitely) specified editor to edit these files.

The files can be specified in 3 ways:

  * just as a filename

  * a Pair with filename as key, and line number as value

  * a Pair with filename as key, and a line number => column Pair as value

The following additional optional named arguments can be specified:

### :editor

Specifies the editor to be used. Defaults to the contents of `$*EDITOR` or `%*ENV<EDITOR>` or 'vim'.

### :tag

An optional tag to be added to each location specified. Defaults to `" "` (aka a space).

SUPPORTED EDITORS
=================

These editors are currently supported:

  * vi

  * vim

  * view

  * nvim

SUPPORTING YOUR OWN EDITOR
==========================

```raku
use Edit::Files;

my sub feditor(@specs, $tag) {
    # handle specs
    run 'feditor', ...
}

edit-files <foo bar>, :editor(&feditor); # edit "foo" and "bar" with "feditor"
```

You can add your own editor to the list of editors supported by `Edit::Files` by creating a `sub` that accepts an array with file / line / column specifications and a tag to be applied. Then you can specify that subroutine in the `:editor` argument to `edit-files`.

ADDING AN EDITOR TO THIS DISTRIBUTION
=====================================

Create a `sub` as described above, and create a [Pull Request](https://github.com/lizmat/Edit-Files/pulls) to have that subroutine added to this distribution.

CAVEATS
=======

Redirected STDIN
----------------

If `STDIN` was redirected, then the `$*IN` handle will be closed, and be opened again with a TTY (by opening `/dev/tty`). This may not work on some operating systems, most notably Windows.

ACKNOWLEDGEMENTS
================

Thanks to Damian Conway for showing the way to handle multiple files / lines using the compilation error `-q` feature of `vim`.

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/Edit-Files . Comments and Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a [small sponsorship](https://github.com/sponsors/lizmat/) would mean a great deal to me!

COPYRIGHT AND LICENSE
=====================

Copyright 2022 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

