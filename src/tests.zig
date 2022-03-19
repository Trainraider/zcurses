const std = @import("std");
const nc = @import("ncurses.zig");

test "Init and deinit" {
    _ = nc.initscr();
    try nc.endwin();
}
