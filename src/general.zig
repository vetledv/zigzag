const std = @import("std");

const delimiter: u8 = '\n';
const max_size: usize = 1024;

///call input.deinit() to free the memory
pub fn read_input(allocator: std.mem.Allocator) !std.ArrayList(u8) {
    const reader = std.io.getStdIn().reader();
    var arr_list = std.ArrayList(u8).init(allocator);

    try reader.streamUntilDelimiter(arr_list.writer(), delimiter, max_size);

    return arr_list;
}

///call allocator.free(slice) to free the memory
pub fn read_input_to_slice(allocator: std.mem.Allocator) ![]u8 {
    const reader = std.io.getStdIn().reader();
    var arr_list = std.ArrayList(u8).init(allocator);

    try reader.streamUntilDelimiter(arr_list.writer(), delimiter, max_size);

    return arr_list.toOwnedSlice();
}
