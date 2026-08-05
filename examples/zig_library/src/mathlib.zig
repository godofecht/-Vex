//! A pure-Zig static library built by Zaza (zig_root), exporting a C-ABI
//! symbol so an executable can link and call it across the archive boundary.
export fn zaza_add(a: i32, b: i32) i32 {
    return a + b;
}
