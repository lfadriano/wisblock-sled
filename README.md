# LoRa "Baton Node" — 40 mm PVC

This repository documents the construction of a tubular ("baton" style) LoRa
repeater node, designed for continuous, autonomous outdoor operation under severe
weather. A 3D-printed internal sled slides into a hermetically sealed PVC pipe,
giving IP68 protection against rain and heat without compromising RF efficiency.

![the sled](dist/iso.png)

## 🛠️ Hardware

- **Core & radio:** RAK19007 Base Board with a WisBlock LoRa Core (nRF52840) at
  **923.125 MHz** (Brazilian frequency plan).
- **Power:** 3.2 V battery with BMS protection, charged by a 5 W / 5 V solar panel
  through a cable gland. Although not officially documented by the manufacturer,
  chip engineers acknowledge that this 3.2 V configuration performs significantly
  better and is safer in hot climates where the battery sits in the sun.
- **Antenna:** IPEX-to-SMA-female pigtail mounted on the top cap.

## 🏗️ Mechanical structure (the sled)

To keep components secure and prevent vibration-induced shorts, the node uses a
custom internal chassis, printed as a single piece.

- **Size:** **200.5 mm** end to end, **34.62 mm** across the wings — a sliding
  interference fit inside Brazilian 40 mm PVC pipe (34.5 mm ID).
- **Cable management:** oblong slots take nylon zip ties for loose wiring, and two
  dedicated side slots route the LoRa and BLE antenna wires safely under the board
  instead of letting them chafe between the plate and the pipe wall.
- **Battery:** an 18650 holder with a print-in-place spring drops into a through
  cutout in the plate.
- **Antenna end:** a Ø34.4 mm circular flange closes the tube, with a hex recess
  (8.41 mm across flats) that keys the panel-mount SMA female connector.

The model is parametric OpenSCAD and **does not redraw** the third-party parts: it
imports the original STLs and unions/cuts around them, so holes, standoffs and the
spring mechanism stay exactly as their authors designed them.

## 💧 Sealing and moisture control (IP68)

The casing handles extreme thermal humidity through a layered defense.

- **Body & top cap:** 40 mm smooth white PVC pipe with a cold-welded top cap. The
  cap is drilled and sealed with PU/silicone under the washer, securing the external
  SMA female connector.
- **Base & breather valve (critical):** a threaded base adapter sealed with Teflon
  tape houses an **IP68 PTFE breather valve**. It equalizes internal pressure and
  prevents condensation ("sweating") during sudden temperature drops, keeping the
  electronics dry.

## ⚡ Power autonomy

Thanks to the ultra-low consumption of the nRF52840 and the WisBlock ecosystem, the
3.2 V cell guarantees weeks of operation even through continuous rain or full
shading. The RAK19007's native regulator efficiently manages the 5 V input from the
external solar panel to keep the cell topped up.

## Building

| File in `vendor/` | What it is | Included here? |
|---|---|---|
| `Wisblock_Plate_V1.1.stl` | WisBlock mounting plate (Ethernet/POE) | yes |
| `18650_V2.STL` | 18650 holder with printed spring | **no** — download it (see [Credits](#credits)) and drop it in `vendor/` |

```sh
openscad -o dist/Wisblock_Sled.stl wisblock_sled.scad
```

## Printing

**Material: PETG, ABS or ASA, 30% infill. Avoid PLA** — it deforms from the heat
that builds up inside a sealed tube in the sun.

**Print it flat, on its flat face. Do not print it upright.** The holder's spring
compresses along the length (X); lying flat, the layers run in the plane of that
motion. Standing upright, X becomes the stacking direction and the spring
delaminates. The battery holder sits in a through cutout with its underside flush
with the base, so the part rests directly on the bed and needs **no support** — the
spring prints bed-supported instead of bridging.

> **Fit vs. material.** The wing geometry was tuned on PLA prototypes, where the
> wings cracked at the root, so `fit_clear` is deliberately conservative at
> −0.12 mm. PETG, ABS and ASA are far tougher and tolerate more preload: if the fit
> feels loose in your production material, go to `-0.18` or `-0.25`. That −0.25
> value is exactly what snapped in PLA — it should be safe in ASA.

### Battery contacts

The 18650 holder takes its electrical contacts from **brass standoffs**, per its
author: `M3x6+6 (20A)` or `M4x6+6 (30A)`. They are not part of the printed model.

## Key parameters

| Parameter | Value | Notes |
|---|---|---|
| `fit_clear` | `-0.12` | negative means **interference** against the pipe. See the note above |
| `wall_base` | `3.0` | **do not increase**: it eats the internal clearance and pinches the PCB |
| `wall_tip` | `1.8` | wing tip; below 1.6 mm PLA snaps at the root |
| `fillet` | `3.0` | fillet at the wing root — the main anti-crack reinforcement |
| `disc_flat` | `true` | clips the disc at z=0 → flat base, no support needed |
| `cable_swap` | `true` | swaps which side each cable slot exits on |
| `tail_len` | `15.0` | tail past the battery, carrying the zip-tie slots |

## Non-obvious design decisions

- **The wings grip by interference, not clearance.** v1 used +0.20 mm clearance and
  was loose. 0.25 mm of interference with a 1.4 mm tip snapped at the root under
  finger pressure alone — in PLA the failure is *interlaminar*, at the sharp inside
  corner. The fix was a 3 mm fillet at the root (it fits entirely **below** the PCB),
  a 1.8 mm tip, and less interference.
- **Wing root thickness is capped by the PCB**, not by strength: taking `wall_base`
  to 4.0 mm would drop the internal clearance from 28.18 to 26.41 mm, pinching a
  board that is ~5 mm tall with components.
- **The M2 holes are re-cut after the fillet**, otherwise it blocks a screw.
- **A through cutout instead of a step** for the battery holder: it removes the need
  for print support, lets the spring print bed-supported, and raises clearance to the
  pipe wall to 3.37 mm.
- **Side convention:** "left" = low y, "right" = high y. The high-y side is
  identifiable by a lone M2 hole 1.70 mm from the edge (y = 28.08).

## Credits

This sled builds on parts by other authors:

- **18650 battery holder with printed spring** (`18650_V2.STL`) by
  **Alex Yang (YXC)**, licensed **CC BY-NC**. Not redistributed here; download it
  from [thingiverse.com/thing:2668159](https://www.thingiverse.com/thing:2668159)
  and drop it in `vendor/`.
- **WisBlock mounting plate** (`Wisblock_Plate_V1.1.stl`) — included in `vendor/`.
- **RAK19007 WisBlock Base Board 2nd Gen** — the board's own 3D model, published by
  the manufacturer on the
  [RAK Wireless store page](https://store.rakwireless.com/products/rak19007-wisblock-base-board-2nd-gen),
  was used only to take measurements (60 × 30 mm). It is not part of this repository.

## License

`wisblock_sled.scad` and this documentation are the work of this repository's author.

**The compiled STL in `dist/` is a derivative work of a CC BY-NC model**, so it
inherits that restriction: attribution to Alex Yang (YXC) and **non-commercial use
only**. CC BY-NC does permit derivatives, which is why the compiled file can be
shared here at all — but it may not be sold or used in a commercial product.
