from math import floor, ceil, log2


def fixed_point_to_float_analytical(fp_num, m, n, debug=False):
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


def fixed_point_to_float(fp_num, n):
    """
    Improved conversion from fixed point to float.
    Deprecated version: fixed_point_to_float_analytical().
    """
    return fp_num/(2**n)


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


def twos_comp(val, bits):
    """compute the 2's complement of int value val"""
    if (val & (1 << (bits - 1))) != 0: # if sign bit is set e.g., 8bit: 128-255
        val = val - (1 << bits)        # compute negative value
    return val


def fixed_point_add(n1, n2):
    """
    Perform addition of fixed point numbers.
    """
    return n1 + n1


def fixed_point_sub(n1, n2):
    """
    Perform addition of fixed point numbers.
    """
    return n1 - n1


def fixed_point_mul(num1, num2):
    """
    INPUT:
        The input is in the form of a tuple: t, where
        t = (fixed_point_number, n) where n is the number of fractional bits.

    OUTPUT:
        - num3: fixed point multiplication result
        - frac: the fractional bitwidth of the new number

    You can use that result to convert it back to a real number:
        fixed_point_to_float(num3, frac)

    EXAMPLE:
        fp1 = utils.float_to_fixed_point_int(3.1, 13)
        fp2 = utils.float_to_fixed_point_int(2.7, 12)
        nfp, frac = utils.fixed_point_mul(num1=(fp1, 13), num2=(fp2, 12))
        utils.fixed_point_to_float(nfp, frac)
        >>> 8.369782716035843
    """
    num3 = num1[0] * num2[0]
    frac = num1[1] + num2[1]
    return num3, frac


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
