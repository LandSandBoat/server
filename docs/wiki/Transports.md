# Ships and Elevators

Ships and elevators live in the zone data files rather than in SQL or Lua, and both run off the same server tick. This page covers how to declare one and how to measure its numbers from a retail packet capture.

Every value in these files should come from a capture. If you cannot measure something, leave it out and mark it `-- Capture needed` rather than filling it with a plausible number.

All figures on this page come from captures taken between 2026-08-23 and 2026-08-29 on the current retail client.

## Where things live

| What                              | File                          | Block                           |
|-----------------------------------|-------------------------------|---------------------------------|
| Ships, boats, airships, the barge | `data/zones/<zone>/zone.yaml` | `transport:`                    |
| Elevators                         | `data/zones/<zone>/npcs.yaml` | `elevator:` on the platform NPC |

Declare a ship in the zone it docks in. The crossing it feeds may be another zone, and on a multi-process server another process, so LSB registers each half on its own.

Declare an elevator on the platform NPC, since the platform, both doors and the schedule all sit in one zone.

---

# Elevators

## Declaring one

```yaml
17748035:
  script: '@6l0'
  render:
    look:
      type: elevator
    animation: elevator_up
  elevator:
    lower_door: _6lv
    upper_door: _6lu
    travel:     8
    period:     18250
```

| Field                       | Meaning                                                                 |
|-----------------------------|-------------------------------------------------------------------------|
| `lower_door` / `upper_door` | Script names of the two door NPCs, resolved against the zone's own NPCs |
| `travel`                    | Seconds between floors, and what the client animates against            |
| `period`                    | Milliseconds for one leg: travel plus the wait at the floor             |
| `lever`                     | Which lever drives it. Omit for a lift that runs itself                 |
| `reversed`                  | Set when the shaft plays the up animation to go down                    |

`period` uses milliseconds because retail's legs run on fractions of a second. `travel` uses whole seconds because the wire field is one byte.

The platform's `animation` sets its starting floor. `elevator_up` starts it at the top, `elevator_down` at the bottom, and `reversed` flips that.

A lift with a `lever` waits to be pulled and needs no `period`. A lift with no `lever` runs on a timer and must have one, or the server refuses to start.

## Reading it from a capture

Everything comes from `0x00E` packets for the platform entity.

| Offset | Field                | Use                                                                |
|--------|----------------------|--------------------------------------------------------------------|
| `0x04` | `UniqueNo`           | Filter to the platform                                             |
| `0x0A` | `SendFlg`            | Ignore any packet where this is 0. It carries no position or state |
| `0x1F` | animation            | `elevator_up` / `elevator_down`, which way it is going             |
| `0x38` | `TransportTimestamp` | Phase start, in whole seconds since the Vana'diel epoch            |
| `0x3C` | `EndTime`            | The travel time. Read `travel` straight off this                   |

**`travel`** sits in `EndTime`. Read it off any packet.

**`period`** takes more work. Collect the distinct `TransportTimestamp` values and take the gaps between consecutive ones. Each gap is one leg.

`TransportTimestamp` holds whole seconds, so a fractional period shows up as two adjacent gap values in a fixed ratio, not one number:

```
psoxja tower A    19s x1266   20s x187    period 19.129s    period: 19129
psoxja tower B    20s x445    21s x899    period 20.669s    period: 20669
psoxja tower C    23s x962    24s x236    period 23.197s    period: 23197
metalworks        18s x3      19s x1      period 18.250s    period: 18250
```

The period is `(last stamp - first stamp) / number of legs`. The three Pso'Xja figures come from unbroken runs of over 1,000 legs each, which puts them inside a thousandth of a second. Metalworks rests on four legs from a short capture, so trust it least.

One gap value means the period really is whole. Two mean it is fractional, so take the mean instead of picking one.

These periods do not follow the Vana'diel clock. Fitting Pso'Xja tower A against 8 vana minutes (19.2s) drifts 104 seconds across one unbroken 27,794 second run.

Check `period` minus `travel` afterwards. That is the wait at the floor, and a negative or near-zero result means one of the two is wrong.

---

# Ships

## Declaring one

```yaml
transport:
  ship: 17784936
  runs:
    jeuno_kazham_airship:
      door: _6uv
      dock: [-4.000, 10.450, 117.000, 64]
      places:
        staging: [-43.000, 10.450, 190.000]
      boundary:  477
      voyage:    kazham_jeuno_airship
      every:     864
      disembark: 456
      offset:    650
      phases:
        - state:     arriving
          animation: animation_24
          seconds:   45
          moves:
            - to: dock
        - state:   docked
          seconds: 118
        - state:   closing
          seconds: 3
        - state:     departing
          animation: animation_25
          hide:      46
          moves:
            - to:    staging
              after: 1
```

State `ship:` once for the zone. Several runs can share it, each taking its turn through its `offset`. Port Jeuno runs one airship across four berths this way.

| Field       | Meaning                                                                                  |
|-------------|------------------------------------------------------------------------------------------|
| `door`      | Script name of the boarding door. Omit on a run that carries nobody                      |
| `dock`      | The berth, as x, y, z and an optional facing. Omit on a decorative ship that never moves |
| `places`    | Named spots the phases can move to. `dock` is always available without declaring it      |
| `boundary`  | Boarding area. Whoever stands in it rides along when the ship departs                    |
| `voyage`    | The zone passengers cross. Omit if the run carries nobody                                |
| `every`     | Cycle length in seconds                                                                  |
| `offset`    | Seconds the cycle is shifted by                                                          |
| `disembark` | Seconds into the cycle when riders in the crossing are put ashore                        |
| `phases`    | The cycle in order, starting at the offset                                               |

### Phases

A phase says what the ship is doing for a stretch of the cycle. The states are `arriving`, `docked`, `closing` and `departing`, plus `cycling` and `holding` for decorative ships.

Phases run back to back and must total exactly `every`. Leave `seconds` off exactly one phase and it takes whatever is left.

| Phase field | Meaning                                                        |
|-------------|----------------------------------------------------------------|
| `animation` | What the client plays, timed from the moment the phase began   |
| `seconds`   | How long it lasts                                              |
| `moves`     | Where the ship is put during the phase, and how far into it    |
| `hide`      | Seconds into the phase after which the client stops drawing it |

`moves` and `hide` sit apart from the state on purpose. Retail moves a ship partway through an animation under the same timestamp, and hides it partway into `departing` instead of at a phase boundary. A phase with no `moves` leaves the ship where the last one put it.

## Reading it from a capture

Same packet as the lifts, and the same `SendFlg` warning. A packet with `SendFlg = 0` carries no position block, and its position bytes read as a false `(0, 0, 0)`.

| Offset               | Field                | Use                                               |
|----------------------|----------------------|---------------------------------------------------|
| `0x0A`               | `SendFlg`            | Skip the packet if this is 0                      |
| `0x0C` `0x10` `0x14` | x, y, z              | Berths and named places                           |
| `0x18`               | `flags0`             | Low 13 bits are `MovTime`, bit 15 is `GroundFlag` |
| `0x1F`               | animation            | Which phase started                               |
| `0x20`               | `flags1`             | Bit 1 is `HideFlag`, which is what `hide` encodes |
| `0x30`               | `SubKind` / `Status` | SubKind 4 is a ship, 3 a lift                     |
| `0x34`               | `DoorId`             |                                                   |
| `0x38`               | `TransportTimestamp` | Phase start                                       |

### Getting the schedule

1. **`every`.** Take the gaps between phase stamps carrying the same animation. Ferries and airships are Vana'diel-aligned: 864s is 360 vana minutes, 1152s is 480, 3456s is a full vana day.
2. **`offset`.** `stamp % every` for the first phase. Every capture should give the same value. Drift means the cycle length is wrong.
3. **Phase lengths.** The gap between one phase stamp and the next.
4. **`docked` and `closing`.** These two share the arriving animation and get no stamp of their own. Time them off the boarding door, which opens when `docked` begins and shuts when `closing` begins. Filter the door entity to animations 8 (open) and 9 (shut).

### Getting `moves`

For each phase, take every position-bearing packet during it and subtract the phase stamp from the packet's wall-clock time. That gives the offset into the phase at which the ship was put there.

```
jeuno   anim 19   +0s berth(-68, 117)     +1s staging(-29, 190)
barge   anim 23   +0s hidden(0, 100, 0)   +1s berth   +54s outbound   +77s hidden
```

Most ships move only at the phase start. Only the barge needs several waypoints in one phase.

### Getting `hide`

Track `flags1` bit 1 across the phase. The client draws the ship at the start of `departing` and drops it some seconds in, once the animation has carried it out of sight:

```
windurst 29s   jeuno 33s   sandoria 35s   bastok 37s   kazham 38s   manaclipper 41s
```

The barge never sets `HideFlag`. It ducks under the map to `(0, 100, 0)` instead, which is why it uses `moves` where the others use `hide`.

### Getting `disembark`

Ride the crossing with a capture running. The `0x00A` zone-in packet marks the moment you land, and its position in the run's cycle is `disembark`.

Do not infer it from the ship's schedule. Two of the three manaclipper legs held another leg's value and carried riders to the wrong stop, until four captured rides corrected them.

## Common mistakes

**Both directions share a crossing.** The outbound and return legs use one zone, which empties only when neither has anyone aboard. Check one leg alone and each direction throws the other's passengers out the moment they board.

**Not every ship moves.** Windurst, Bastok and Kazham never leave their berths. Across a full away window every position-bearing packet shows the same coordinates with `MovTime` 1, from 7, 9 and 6 packets. They look like they fly off because the animation does it. Do not invent a staging spot for them.

**Absence counts only if you watched long enough.** Before deciding a ship has no second position, check the capture spans a whole cycle with the ship in view. Otherwise you are measuring when the capturer walked away.
