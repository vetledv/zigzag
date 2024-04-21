const std = @import("std");
const general = @import("general.zig");
const debugPrint = std.debug.print;

fn print_cmds() !void {
    const writer = std.io.getStdOut().writer();
    try writer.print("{s}\n", .{"-" ** 32});
    try writer.print("Hello World!\n", .{});
    try writer.print("{s}\n", .{"-" ** 32});
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    try print_cmds();

    debugPrint("Enter a value: ", .{});

    const input = try general.read_input(allocator);
    defer input.deinit();

    debugPrint("You entered: {s}\n", .{input.items});
    debugPrint("Enter another value: ", .{});

    const slice = try general.read_input_to_slice(allocator);
    defer allocator.free(slice);

    debugPrint("You entered: {s}\n", .{slice});
}
