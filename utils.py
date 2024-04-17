from math import floor, ceil, log2


def fixed_point_to_float(fp_num, m, n, debug=False):
    """
    Converts a fix point integer number back to (real) float.
    May introduce quantization error.
    We're using Q number notation: https://en.wikipedia.org/wiki/Q_(number_format)

    INPUT:
        - n: Fixed point integer number
        - m: number of integer bits
        - n: number of decimal bits

    OUTPUT: The quantized result of the fixed point number
    """

    # expand the number to word length
    bfp = bin(fp_num)[2:]
    bfp = bfp.zfill(m+n)

    # Extract integer part
    bin_int_part = bfp[0:m]
    rev_bin_int_part = bin_int_part[::-1]

    # Integer part calculation
    int_part_sum = 0
    for i in range(len(rev_bin_int_part)):
        if debug:
            print(f"i={i}, n={rev_bin_int_part[i]}")
        int_part_sum += int(rev_bin_int_part[i]) * 2**i

    # Extract decimal part
    bin_float_part = bfp[m:]

    # Float part calculation
    float_part_sum = 0
    for i in range(len(bin_float_part)):
        if debug:
            print(f"i={i}, n={bin_float_part[i]}, {1/2**(i+1)}")
        if bin_float_part[i] == '1':
            float_part_sum += 1/2**(i+1)

    return int_part_sum + float_part_sum


def float_to_fixed_point_int(fl_num, n):
    """
    Returns the fixed point integer of the given floating point number.

    INPUT:
        - fl_num : the number we want to convert to fixed point
        - m : the number of fractional bits

    Example:
        float_to_fixed_point_int(3.14, 13)
        >>> 25722
    """

    return floor(fl_num * 2**n)


def float_to_fixed_point_bin(fl_num, m, n):
    s1 = floor(fl_num * 2**n)
    s2 = bin(s1)[2:]
    return s2.zfill(n+m)


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
    """
    Calculate the required number of bits for a multiplication of two signed
    signals. The calculation assumes that negative values are always in
    two's complement.

    Does the same thing as sigint_add_bw() but for multiplication.
    """

    min_result = abs(n1_range[0] * n2_range[0])
    max_result = abs(n1_range[1] * n2_range[1])
    max_magnitude = max(min_result, max_result)
    return get_bw(max_magnitude)


if __name__ == "__main__":
    #print(sigint_add_bw((-200, 100), (-20, 20)))
    #print(to_fixed_point(3.14, 16))
    #print(to_float(to_fixed_point(3.14, 16)))
    print(to_float('0b10101100'))
