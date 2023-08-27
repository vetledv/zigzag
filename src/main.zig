const std = @import("std");
const dprint = std.debug.print;

const u8arr_list: type = std.ArrayList(u8);

fn print_cmds() !void {
    const writer = std.io.getStdOut().writer();
    try writer.print("{s}\n", .{"-" ** 32});
    try writer.print("Hello World!\n", .{});
    try writer.print("{s}\n", .{"-" ** 32});
}

const delimiter = '\n';

fn read_input() u8arr_list {
    const reader = std.io.getStdIn().reader();

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();
    defer allocator.deinit();

    var input = std.ArrayList(u8).init(allocator);
    defer input.deinit();

    try reader.streamUntilDelimiter(input.writer(), delimiter, 1024);

    return input;
}

pub fn main() !void {
    try print_cmds();
}
