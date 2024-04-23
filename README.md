# silicon Neural Networks - sNN

Journey with creating hardware (silicon) neural networks.

## Files and Directories

### perceptron_v1

- Using `integer` to define I/O.
- Created:
  - `neuron`
  - `ReLU`


### perceptron_v2

- Used:
    - `std_logic_vector`
    - `std_logic_signed`
- Created:
    - `neuron`
    - `ReLU`.

### perceptron_v3

- Using `component` to bind `neuron` and `relu` I/O.
- Created:
  - `perceptron`


### perceptron_v4

- Introduced `clk`
- Created `clk process`


### perceptron_v5

Experimented with using `Fixed Point Arithmetic` to represent floating point numbers.

Made changes only to the `neuron`.

Simulation looks good!

### perceptron_fflib

A functioning perceptron which uses fixed point arithmetic for floating point numbers.

