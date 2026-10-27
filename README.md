# Charybdis nano wireless


## (Partial) guide

### Parts

- Nice!nano adapter PCB: I used the one from https://github.com/olidacombe/Elite-C-holder (there's [another one](https://github.com/olidacombe/Elite-C-holder), which allows using external power switches)
- pmw3610 sensor: [aliexpress](https://fr.aliexpress.com/item/1005006913778101.html)
- Custom adapter bottom, because the sensor pcb is not the same size as bastard kb's. I made [this one](./assets/adapter_BTU_bottom_smaller_pmw3610.stl) (made from BTU mod adapter, I just added some mounting holes). Will need M2 inserts to fix sensor pcb onto.

### Wiring

The wiring for the sensor was done according to this table:

| MCU adapter |   | pmw3610 |
|-------------|---|---------|
| VCC         |   | VDD     |
| CST         |   | NCS     |
| MOSI        |   | SDIO    |
| SCLK        |   | SCLK    |
| MISO        |   | MOTION  |
| GND         |   | GND     |

**Warning:** on the pmw3610 pcb, use the **VDD** pin, not the **VDIO** pin (which expects a max of 3.3V).

### Software

This (forked) repo contains the software that I use. There are three files that you may need to modify:
- [config/charybdis.keymap](./config/charybdis.keymap) : keymap
- [config/boards/shields/charybdis/charybdis_right.conf](./config/boards/shields/charybdis/charybdis_right.conf) : sensor power/sampling options. Options are described [here](https://github.com/badjeff/zmk-pmw3610-driver/blob/main/Kconfig)
- [config/boards/shields/charybdis/charybdis_right.overlay](./config/boards/shields/charybdis/charybdis_right.overlay) : sensor CPI, orientation and layer-specific behaviour (e.g. scroll layer), using ZMK [input processors](https://zmk.dev/docs/keymaps/input-processors/usage)

Firmware is built against ZMK `main` (Zephyr 4.1), with the [badjeff PMW3610 driver](https://github.com/badjeff/zmk-pmw3610-driver).

## Resources

Other build guide: https://github.com/erenatas/charybdis-wireless-3x6
