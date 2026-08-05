const std = @import("std");

extern fn zaza_add(a: i32, b: i32) i32;

pub fn main() void {
    const result = zaza_add(2, 3);
    std.debug.print("zaza_add(2, 3) = {d}\n", .{result});
    if (result != 5) std.process.exit(1);
}
