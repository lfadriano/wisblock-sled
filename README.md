# WisBlock Sled — 40 mm PVC pipe

A 3D-printed sled that slides by friction inside a **40 mm OD / 34.5 mm ID** PVC
pipe, carrying:

- a **RAK19007 WisBlock Base** (60 × 30 mm) bolted to the original M2 holes;
- an **18650 cell** in a holder with a print-in-place serpentine spring;
- a panel-mount **female SMA connector** on a Ø34.4 mm circular flange that closes
  the end of the pipe.

Final size: **200.5 × 34.62 × 25.21 mm**.

The model is parametric OpenSCAD and **does not redraw** the third-party parts: it
imports the original STLs and unions/cuts around them, so holes, standoffs and the
spring mechanism stay exactly as designed.

## Building

| File in `vendor/` | What it is | Included here? |
|---|---|---|
| `Wisblock_Plate_V1.1.stl` | WisBlock mounting plate (Ethernet/POE) | yes |
| `18650_V2.STL` | 18650 holder with printed spring | **no** — download it (see [Credits](#credits)) and drop it in `vendor/` |

```sh
openscad -o dist/Wisblock_Sled.stl wisblock_sled.scad
```

## Printing

**Print it flat, on its flat face. Do not print it upright.** The holder's spring
compresses along the length (X); lying flat, the layers run in the plane of that
motion. Standing up, X becomes the stacking direction and the spring delaminates.

The battery holder drops into a **through cutout** in the plate, its underside
flush with the base — so it sits straight on the bed and needs **no support**. The
spring prints supported instead of bridging.

Tested in PLA.

### Battery contacts

The 18650 holder takes its electrical contacts from **brass standoffs**, per its
author: `M3x6+6 (20A)` or `M4x6+6 (30A)`. They are not part of the printed model.

## Key parameters

| Parameter | Value | Notes |
|---|---|---|
| `fit_clear` | `-0.12` | negative means **interference** against the pipe. `-0.18` is tighter |
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
  a 1.8 mm tip, and less interference (0.12 mm).
- **Wing root thickness is capped by the PCB**, not by strength: taking `wall_base`
  to 4.0 mm would drop the internal clearance from 28.18 to 26.41 mm.
- **The M2 holes are re-cut after the fillet**, otherwise it blocks a screw.
- **A through cutout instead of a step** for the battery holder: kills the print
  support, lets the spring print bed-supported, and raises pipe clearance to 3.37 mm.
- **Side convention:** "left" = low y, "right" = high y. The high-y side is
  identifiable by a lone M2 hole 1.70 mm from the edge (y = 28.08).

## Credits

This sled builds on two models by other authors, which keep their original licenses:

- **18650 battery holder with printed spring** (`18650_V2.STL`) by **Alex Yang (YXC)** —
  not redistributed here. Download it from
  [thingiverse.com/thing:2668159](https://www.thingiverse.com/thing:2668159) and drop
  it in `vendor/`.
- **WisBlock mounting plate** (`Wisblock_Plate_V1.1.stl`) — included in `vendor/`.

## License

`wisblock_sled.scad` and this documentation are the work of this repository's
author. The compiled STL in `dist/` is a derivative work of the models above.
