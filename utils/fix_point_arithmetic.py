"""
Fixed point arithmetic conversions and operations as explained here https://www.youtube.com/watch?v=Is67DfCdvcE

This technique of representing floating point numbers using integers should be usable in FPGAs.
"""
from math import floor


def to_fixed_point(inp_num, nof_fp_bits):
    """
    Returns the representation of a floating point number using integers.

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
    pass


def fp_mul():
    pass


def fp_div():
    pass


#---------------------------------------------------------#

inp_num = 3.141
nof_reg_bits = 16
fp_num = to_fixed_point(inp_num, nof_reg_bits)
fl_num = to_float(fp_num)
print(f"{inp_num} in FPA: {fp_num} and converted back to float: {fl_num}")

# test addition -1 
n1 = 2.28
n2 = 1
nof_bits = 16

print(f"{n1} + {n2} == {to_float(fp_add_d(to_fixed_point(n1, 16), to_fixed_point(n2, 16)))}")

# test addition -2
n1 = 2.28
n2 = 1.25
nof_bits = 16

print(f"{n1} + {n2} == {to_float(fp_add_d(to_fixed_point(n1, 16), to_fixed_point(n2, 16)))}")
