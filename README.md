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

SUPPORTED EDITORS
=================

At this writing, only `vim` is supported.

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

