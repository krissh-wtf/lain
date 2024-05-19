# optimize for console use
switch("app", "console")

# optimize for release build (better performance)
switch("define", "release")

# compiler & linker optimizations for size and speed
switch("panics", "on")
switch("threads", "on")
switch("opt", "size")
switch("gc", "arc")
switch("passC", "-O3 -m64 -march=native -ffast-math")
switch("passL", "-flto=auto")