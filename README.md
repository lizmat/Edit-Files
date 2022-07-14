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

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/Edit-Files . Comments and Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a [small sponsorship](https://github.com/sponsors/lizmat/) would mean a great deal to me!

COPYRIGHT AND LICENSE
=====================

Copyright 2022 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

