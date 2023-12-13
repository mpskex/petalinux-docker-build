# petalinux-docker-build
Build petalinux docker image


## Before you start

1. Make sure you have already downloaded [petalinux tools](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html). 
2. Place the downloaded `.run` file into `install/` directory

## How to use

- `make image`: build image locally using your downloaded installer
- `make container`: use your built image to create a container


```mermaid
flowchart TD

subgraph Z["Zynq UltraScale+ MPSoc Design Flow"]
direction LR
    a[start] ---> |PL design| b[chisel design]
    b --->|chisel-dev image| c[verilog design]
    c ---> |vivado| d[xsa hardware design]
    a ---> |PS design| ea[source]
    ea ---> |XSCT| eb[linux application]
    eb ---> |petalinux-config|e[petalinux project]
    d ---> |petalinux-config|e
    e ---> |petalinux-dev| f[petalinux-dev image]
    f ---> |JTAG|g[boot]
end
```