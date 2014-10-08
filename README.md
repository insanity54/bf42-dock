bff
===

battlefield 1942 server manager for post gamespy shutdown


Prerequisites
---

* [docker](https://docker.com/)


Building
---

    $ docker build -t bf42 .
    $ docker run -d bf42


Notes
---

Battlefield 1942 needs these ports:

* 14567/udp - game traffic
* 3117/udp  - server browser client request (LAN only)
* 22000/udp - server browser response (LAN only)
