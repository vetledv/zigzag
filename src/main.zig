const std = @import("std");
const general = @import("general.zig");
const dprint = std.debug.print;

fn print_cmds() !void {
    const writer = std.io.getStdOut().writer();
    try writer.print("{s}\n", .{"-" ** 32});
    try writer.print("Hello World!\n", .{});
    //TODO: random commands
    try writer.print("{s}\n", .{"-" ** 32});
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    //error: value of type 'heap.general_purpose_allocator.Check' ignored
    //all non-void values must be used
    //this error can be suppressed by assigning the value to '_'
    //TODO: git gud, I don't get this error
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    try print_cmds();

    dprint("Enter a value: ", .{});

    const input = try general.read_input(allocator);
    defer input.deinit();

    dprint("You entered: {s}\n", .{input.items});
    dprint("Enter another value: ", .{});

    const slice = try general.read_input_to_slice(allocator);
    defer allocator.free(slice);

    dprint("You entered: {s}\n", .{slice});
}
