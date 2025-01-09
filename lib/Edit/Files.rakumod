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

    # Make sure we have a TTY connected to STDIN
    if $*IN.t {
        run $editor, '-q', $tmpfile.absolute;
    }
    else {
        my $*IN = open "/dev/tty";  # XXX not sure this works on Windows
        run $editor, '-q', $tmpfile.absolute;
    }

}

# vim: expandtab shiftwidth=4
