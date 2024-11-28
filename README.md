+------------------------+       +---------------------------+
|   EC2 Instance 1       |       |   EC2 Instance 2          |
|  Backend System        |       |  PokeAPI Game             |
|                        |       |                           |
|  +------------------+  |       |   +-------------------+   |
|  | Docker Container |  |       |   | PokeAPI Game App  |   |
|  |    Flask API     |  | <----> |   | (React/JS Frontend) | |
|  +------------------+  |       |   +-------------------+   |
|        ^               |       |                           |
|        |               |       |   Communicates via API    |
|  +------------------+  |       |                           |
|  | Docker Container |  |       +---------------------------+
|  |    MongoDB       |  |
|  +------------------+  |
+------------------------+
