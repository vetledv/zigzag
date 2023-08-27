const std = @import("std");
const stdouta = std.io.getStdOut().writer();

const TWriter: type = std.fs.File.Writer;
const TReader: type = std.fs.File.Reader;

fn print_cmds() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("{s}\n", .{"-" ** 32});
    try stdout.print("0: Exit\n", .{});
    try stdout.print("1: --help\n", .{});
    try stdout.print("2: Print Hello World\n", .{});
    try stdout.print("3: Print sum of 1 + 2\n", .{});
    try stdout.print("{s}\n", .{"-" ** 32});
}

fn add(a: i8, b: i8) i8 {
    return a + b;
}

const delimiter = '\n';

fn get_input_num() !i64 {
    const stdin = std.io.getStdIn().reader();

    var buf: [8]u8 = undefined;

    if (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |value| {
        const line = std.mem.trimRight(u8, value[0 .. value.len - 1], "\r");
        return try std.fmt.parseInt(i64, line, 10);
    } else {
        return @as(i64, 0);
    }
}

fn sum_input_nums() void {
    var val_a: i64 = undefined;
    var val_b: i64 = undefined;

    //TODO: -1 should be allowed
    std.debug.print("Enter first number\n", .{});
    val_a = get_input_num() catch -1;
    std.debug.print("Enter second number\n", .{});
    val_b = get_input_num() catch -1;

    const sum_vals = val_a + val_b;

    return std.debug.print("Sum of {d} + {d} = {d}\n", .{ val_a, val_b, sum_vals });
}

pub fn main() !void {
    try print_cmds();

    while (true) {
        const num = get_input_num() catch -1;
        switch (num) {
            0 => {
                std.debug.print("Terminated process.\n", .{});
                break;
            },
            1 => {
                try print_cmds();
            },
            2 => {
                std.debug.print("Hello world!\n", .{});
            },
            3 => {
                sum_input_nums();
            },
            else => {
                std.debug.print("Invalid input, type 1 to see help\n", .{});
            },
        }
    }
}
