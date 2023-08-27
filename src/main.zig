const std = @import("std");
const dprint = std.debug.print;

fn print_cmds() !void {
    const writer = std.io.getStdOut().writer();
    try writer.print("{s}\n", .{"-" ** 32});
    try writer.print("Hello World!\n", .{});
    //TODO: random commands
    try writer.print("{s}\n", .{"-" ** 32});
}

const delimiter = '\n';

///call input.deinit() to free the memory
fn read_input(allocator: std.mem.Allocator) !std.ArrayList(u8) {
    const reader = std.io.getStdIn().reader();
    var arr_list = std.ArrayList(u8).init(allocator);

    try reader.streamUntilDelimiter(arr_list.writer(), delimiter, 1024);

    return arr_list;
}

///call allocator.free(slice) to free the memory
fn read_input_to_slice(allocator: std.mem.Allocator) ![]u8 {
    const reader = std.io.getStdIn().reader();
    var arr_list = std.ArrayList(u8).init(allocator);

    try reader.streamUntilDelimiter(arr_list.writer(), delimiter, 1024);

    return arr_list.toOwnedSlice();
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    //error: value of type 'heap.general_purpose_allocator.Check' ignored
    //all non-void values must be used
    //this error can be suppressed by assigning the value to '_'
    //I don't get this error
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    try print_cmds();

    dprint("Enter a value: ", .{});
    const input = try read_input(allocator);
    defer input.deinit();

    dprint("You entered: {s}\n", .{input.items});

    dprint("Enter another value: ", .{});
    const slice = try read_input_to_slice(allocator);
    defer allocator.free(slice);
    dprint("You entered: {s}\n", .{slice});
}
