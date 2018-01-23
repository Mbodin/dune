  $ $JBUILDER runtest --force -j1 --root .
  description = "contains \"quotes\""
  requires = "bytes"
  archive(byte) = "foobar.cma"
  archive(native) = "foobar.cmxa"
  plugin(byte) = "foobar.cma"
  plugin(native) = "foobar.cmxs"
  package "baz" (
    directory = "baz"
    description = "sub library with modes set to byte"
    requires = "bytes"
    archive(byte) = "foobar_baz.cma"
    archive(native) = "foobar_baz.cmxa"
    plugin(byte) = "foobar_baz.cma"
    plugin(native) = "foobar_baz.cmxs"
  )
  package "rewriter" (
    directory = "rewriter"
    description = "ppx rewriter"
    requires(ppx_driver) = "foobar foobar.rewriter2"
    archive(ppx_driver,byte) = "foobar_rewriter.cma"
    archive(ppx_driver,native) = "foobar_rewriter.cmxa"
    plugin(ppx_driver,byte) = "foobar_rewriter.cma"
    plugin(ppx_driver,native) = "foobar_rewriter.cmxs"
    # This is what jbuilder uses to find out the runtime dependencies of
    # a preprocessor
    ppx_runtime_deps = "foobar.baz"
    # This line makes things transparent for people mixing preprocessors
    # and normal dependencies
    requires(-ppx_driver) = "foobar.baz foobar_runtime_lib2"
    ppx(-ppx_driver,-custom_ppx) = "./ppx.exe --as-ppx"
  )
  package "rewriter2" (
    directory = "rewriter2"
    description = "ppx rewriter expander"
    requires = "foobar"
    archive(byte) = "foobar_rewriter2.cma"
    archive(native) = "foobar_rewriter2.cmxa"
    plugin(byte) = "foobar_rewriter2.cma"
    plugin(native) = "foobar_rewriter2.cmxs"
    # This is what jbuilder uses to find out the runtime dependencies of
    # a preprocessor
    ppx_runtime_deps = "foobar.runtime-lib2"
  )
  package "runtime-lib2" (
    directory = "runtime-lib2"
    description = "runtime library for foobar.rewriter2"
    requires = ""
    archive(byte) = "foobar_runtime_lib2.cma"
    archive(native) = "foobar_runtime_lib2.cmxa"
    plugin(byte) = "foobar_runtime_lib2.cma"
    plugin(native) = "foobar_runtime_lib2.cmxs"
  )
  package "sub" (
    directory = "sub"
    description = "sub library in a sub dir"
    requires = "bytes"
    archive(byte) = "foobar_sub.cma"
    archive(native) = "foobar_sub.cmxa"
    plugin(byte) = "foobar_sub.cma"
    plugin(native) = "foobar_sub.cmxs"
  )
