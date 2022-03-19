const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const lib = b.addStaticLibrary("zcurses", "src/ncurses.zig");
    lib.setBuildMode(mode);
    lib.install();

    const tests = b.addTest("src/tests.zig");
    tests.setBuildMode(mode);
    tests.linkLibC();
    tests.linkSystemLibrary("ncursesw");

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&tests.step);

}
