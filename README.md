# Rudy

https://people.kth.se/~johanmon/dse/rudy.pdf

# Benchmark of the HTTP server on commit #8efc41e0ef193e2289a50a29ba9905674a31d06c

On Lenovo ThinkPad T470s, with the following hardware specs:
* memory: 16GiB memory (2 * SODIMM DDR4 Synchronous 2133 MHz (0,5 ns))
* cpu: Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz
  * size: 2011MHz
  * capacity: 3500MHz
  * width: 64 bits
  * clock: 100MHz

It take on average, 0.313 seconds for the HTTP server to handle 100 requests.

On Aspire A515-52G, with the following hardware specs:
* memory: 8GiB memory (1 * SODIMM DDR4 Synchronous 2667 MHz (0,4 ns))
* cpu: Intel(R) Core(TM) i5-8265U CPU @ 1.60GHz
  * size: 2926MHz
  * capacity: 4005MHz
  * width: 64 bits
  * clock: 100MHz

It takes on average, 0.354 seconds for the HTTP server to handle 100 requests.
