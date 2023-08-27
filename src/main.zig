const std = @import("std");
const dprint = std.debug.print;

const u8arr_list: type = std.ArrayList(u8);
const u8_slice: type = []const u8;

fn print_cmds() !void {
    const writer = std.io.getStdOut().writer();
    try writer.print("{s}\n", .{"-" ** 32});
    try writer.print("Hello World!\n", .{});
    try writer.print("{s}\n", .{"-" ** 32});
}

const delimiter = '\n';

fn read_input() !void {
    const reader = std.io.getStdIn().reader();

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var input = std.ArrayList(u8).init(allocator);
    defer input.deinit();

    try reader.streamUntilDelimiter(input.writer(), delimiter, 1024);
    dprint("value: {s}\n", .{input.items});
}

pub fn main() !void {
    try print_cmds();
    dprint("Enter a value: ", .{});
    try read_input();
}
