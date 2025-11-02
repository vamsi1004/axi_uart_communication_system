
•	The AXI Stream to UART system transfers parallel data from an AXI-Stream interface to a UART serial channel.
•	Data send by the AXI-Stream master is pushed into a synchronous FIFO buffer. The FIFO output is then serialized and transmitted by the UART transmitter.
•	On the receiver side, the UART receiver deserializes the data, checks parity, and outputs parallel data.
