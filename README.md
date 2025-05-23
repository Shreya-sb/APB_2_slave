# APB_2_slave
This design implements a simple APB (Advanced Peripheral Bus) protocol-based communication system, where both the APB Master and Slave modules are included as part of the Design Under Test (DUT). The DUT operates based on the AMBA APB protocol, which is a low-power, low-complexity interface suitable for simple peripheral communication.APB Slave responds to these transactions based on the APB control signals. It acknowledges transactions using the PREADY signal and either stores incoming data (write operation) or returns stored data (read operation).

![APB_2slave_new drawio](https://github.com/user-attachments/assets/06ca6135-c322-4e58-9a43-77f40bd35854)

