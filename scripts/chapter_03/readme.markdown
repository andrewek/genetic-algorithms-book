# Chapter 03 - Encoding Problems and Solutions

## Suitability of Elixir

The author contends that Elixir is an ideal language for this type of work,
mostly because we're already in the habit of writing functions that take some
data and return some data (rather than writing objects that do stuff to
themselves). In that sense, I suspect any functional language would be well
suited, though Elixir certainly has very pleasant ergonomics.

The author does not touch on this in Chapter 1 that I recall, but I'd suspect
that the ability to do things like `pmap` (and otherwise leverage concurrency
and the BEAM) also make it uniquely suited to this type of work relative to a
single-threaded language. Similarly, Elixir's ability to call other processes
(e.g. with NIFs), utilities, executables, etc. seems like it'll come into play,
though I'd bet that's outside the scope of what the book offers.

## Questions I Have
