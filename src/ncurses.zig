const std = @import("std");
const testing = std.testing;
const nc = @cImport({
    @cInclude("ncurses.h");
});
pub const NCursesError = @import("errors.zig").NCursesError;

pub const WINDOW = nc.WINDOW;

/// `initscr` is normally the first curses routine to call when initializing a 
/// program. A few special routines sometimes need to be called before it; these 
/// are slk_init(3X), filter, ripoffline, use_env. For multiple-terminal 
/// applications, newterm may be called before `initscr`.
/// 
/// The `initscr` code determines the terminal type and initializes all curses data 
/// structures. `initscr` also causes the first call to refresh(3X) to clear the 
/// screen. If errors occur, `initscr` writes an appropriate error message to 
/// standard error and exits; otherwise, a pointer is returned to stdscr.
///
/// `initscr` performs memory allocations and requires additional cleanup. Normally
/// you'd just defer `endwin` when calling `initscr`.
pub fn initscr() *WINDOW {
    return nc.initscr();
}

/// The program must also call `endwin` for each terminal being used before exiting 
/// from curses. If newterm is called more than once for the same terminal, the 
/// first terminal referred to must be the last one for which `endwin` is called.
/// 
/// A program should always call `endwin` before exiting or escaping from curses 
/// mode temporarily. This routine
/// 
/// * resets colors to correspond with the default color pair 0,
/// * moves the cursor to the lower left-hand corner of the screen,
/// * clears the remainder of the line so that it uses the default colors,
/// * sets the cursor to normal visibility (see `curs_set`),
/// * stops cursor-addressing mode using the `exit_ca_mode` terminal capability,
/// * restores tty modes (see `reset_shell_mode`).
/// 
/// Calling `refresh` or `doupdate` after a temporary escape causes the 
/// program to resume visual mode.
pub fn endwin() !void {
    if (nc.endwin() == nc.ERR) {
        return NCursesError.NotInitializedError;
    }
}


test "Used for generating docs" {
    comptime {
        std.testing.refAllDecls(@This());
    }
}