from math import floor, ceil, log2


def to_fixed_point(inp_num, nof_fp_bits):
    """
    Returns the representation of a floating point number using integers.
    https://www.youtube.com/watch?v=Is67DfCdvcE

    inp_num : the number we want to convert to fixed point
    nof_fp_bits : total number of bits for the fix point numbers/registers
    """
    s1 = inp_num * 2**(nof_fp_bits/2)
    s2 = floor(s1)
    s3 = bin(s2)[2:]
    fix_point_bin = s3.zfill(nof_fp_bits)
    return fix_point_bin


def to_float(inp_num):
    """
    Converts a fix point arithmetic number back to float.
    May introduce quantization error.
    """
    int_part = inp_num[0:int(len(inp_num)/2)][::-1]
    int_part_num = 0

    for i in range(len(int_part)):
        if int_part[i] == '1':
            int_part_num += 2**i

    float_part = inp_num[len(int_part):]
    float_part_num = 0

    for i in range(len(float_part)):
        if float_part[i] == '1':
            float_part_num += 1/(2**(i+1))

    return int_part_num + float_part_num


def fp_add_d(n1, n2):
    """
    Perform addition of fixed point numbers.
    This function uses the integer representation
    of the numbers to be added because handling binary
    operations is tough.
    """
    bw = len(n1)
    n1_d = int(n1, 2)
    n2_d = int(n2, 2)
    res_d = n1_d + n2_d
    res_b = bin(res_d)[2:].zfill(bw)
    return res_b


def fp_sub():
    raise Exception("Not implemented")


def fp_mul():
    raise Exception("Not implemented")


def fp_div():
    raise Exception("Not implemented")


def get_bw(magnitude):
    """
    Return the magnitude of the number and the required signal bitwidth.
    """
    return magnitude, ceil(log2(abs(magnitude)+1))


def sigint_add_bw(n1_range, n2_range):
    """
    Calculate the required number of bits for an addition of two signed
    signals. The calculation assumes that negative values are always in
    two's complement.
    ---

    IMPORTANT: the input needs to include the range of the numbers in
    the signals. So if signal1 = 255 (8bits) and signal2 = -100 to 100
    then the bitwidth will be n=9.

    HOW: range from 255-100 to 255+100, so
    sigint_add_bw((0, 255), (-100, 100))

    It's not the value that is taken into account but the magnitube of the
    numbers.
    ----

    INPUT: range of numbers arranged in tupples (min_val, max_val)
    OUTPUT: maximum magnitude, number of required bits

    EXAMPLES:

    With negative values:
    signal1_range = (-100, 100)
    signal2_range = (-20, 20)
    sigint_add_bw((-100, 100), (-20, 20))

    One positive value:
    signal1_range = (0, 100)
    signal2_range = (-20, 20)
    sigint_add_bw((0, 100), (-20, 20))
    """

    # Convert to absolute magnitudes
    min_result = abs(n1_range[0] + n2_range[0])
    max_result = abs(n1_range[1] + n2_range[1])
    max_magnitude = max(min_result, max_result)
    return get_bw(max_magnitude)


def sigint_mul_bw(n1_range, n2_range):

    min_result = abs(n1_range[0] * n2_range[0])
    max_result = abs(n1_range[1] * n2_range[1])
    max_magnitude = max(min_result, max_result)
    return get_bw(max_magnitude)


if __name__ == "__main__":
    print(sigint_add_bw((-200, 100), (-20, 20)))
