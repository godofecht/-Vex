const std = @import("std");
const zaza = @import("../../build_lib/cpp_example.zig");

/// A pure-Zig static library plus a Zig executable that links it. This is the
/// Zig-native counterpart to proof_library: Zaza builds the library from a
/// `.zig` root (zig_root) rather than C/C++ sources.
pub var library = zaza.CppExample.staticLibrary(.{
    .name = "zaza_mathlib",
    .description = "Pure-Zig static library built via zig_root",
    .source_files = &.{},
    .zig_root = "examples/zig_library/src/mathlib.zig",
});

pub fn build(b: *std.Build, target: std.Build.ResolvedTarget, optimize: std.builtin.OptimizeMode) !void {
    const lib = try library.buildWithTarget(b, target);

    const exe = b.addExecutable(.{
        .name = "zig_library_app",
        .root_module = b.createModule(.{
            .root_source_file = b.path("examples/zig_library/src/main.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    exe.root_module.linkLibrary(lib);

    const build_step = b.step("zig-library", "Build the pure-Zig library example");
    build_step.dependOn(&b.addInstallArtifact(lib, .{}).step);
    build_step.dependOn(&b.addInstallArtifact(exe, .{}).step);

    const run = b.addRunArtifact(exe);
    const run_step = b.step("zig-library-run", "Run the pure-Zig library example");
    run_step.dependOn(&run.step);
}
