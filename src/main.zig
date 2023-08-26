const std = @import("std");

const TWriter: type = std.fs.File.Writer;
const TReader: type = std.fs.File.Reader;

const Rect = struct {
    width: u32,
    height: u32,
    fn calcArea(self: *Rect) u32 {
        return self.width * self.height;
    }
};

const rect = Rect{ .width = 10, .height = 20 };

const Command = enum {
    Exit,
    Help,
    Hello,
    Sum,
};

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
    const stdout = std.io.getStdOut().writer();
    const stdin = std.io.getStdIn().reader();

    try stdout.print("Enter a number: ", .{});

    var buf: [8]u8 = undefined;

    if (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |value| {
        const line = std.mem.trimRight(u8, value[0 .. value.len - 1], "\r");
        return try std.fmt.parseInt(i64, line, 10);
    } else {
        return @as(i64, 0);
    }
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    _ = stdout;
    var val_a: i64 = undefined;
    var val_b: i64 = undefined;

    try print_cmds();
    while (true) {
        const num = get_input_num() catch -1;
        switch (num) {
            0 => {
                std.debug.print("Goodbye!\n", .{});
                break;
            },
            1 => {
                try print_cmds();
            },
            2 => {
                std.debug.print("Hello world!\n", .{});
            },
            3 => {
                std.debug.print("Enter first number\n", .{});
                //TODO: -1 should be allowed
                val_a = get_input_num() catch -1;
                std.debug.print("Enter second number\n", .{});
                val_b = get_input_num() catch -1;

                const sum_vals = val_a + val_b;
                std.debug.print("Sum of {d} + {d} = {d}\n", .{ val_a, val_b, sum_vals });
            },
            else => {
                std.debug.print("Invalid input: {d}\n", .{num});
            },
        }
    }
}
