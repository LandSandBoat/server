# Rotation Values
The Rotation Value of an entity represents where it's facing in the world. This is stored and used as `uint8`, meaning that **values range 0~255**.

⚠️ **As such, all degrees on LSB are based on a "256 degree" scale. This is _not_ the same "360 degree" scale that you may be used to.**

Rotation 0 is aligned with as due East, with values increasing as you rotate **to the right**.

⚠️ **Rotation increases going clockwise from 0. This is the _opposite_ of standard Trigonometry.**

[[/images/rotation_values.png|Diagram of rotation values]]

| Rotation Value | Cardinal Direction | (Standard Trig) Pi | "360 Scale" Degree (Clockwise) |
| - | - | - | - |
| **_0_** | **_E_** | 0 | 0 |
| 32 | SE | 7Pi/4 | 45 |
| **_64_** | **_S_** | 3Pi/2 | 90 |
| 96 | SW | 5Pi/4 | 135 |
| **_128_** | **_W_** | Pi | 180 |
| 160 | NW | 3Pi/4 | 225 |
| **_192_** | **_N_** | Pi/2 | 270 |
| 224 | NE | Pi/4 | 315 |

# World Angles
The "World Angle" between Entity A and Entity B is the absolute, cardinal, "world aligned" angle between Entity A and B.

⚠️ **Like Rotation Values, they range 0~255. They are _not_ Trigonometry radians.** (Although they can be converted to radians.)

Measurements start at 0 for due East, and **angles increase going clockwise**.

Either entity's Rotation Value is _not_ a factor in the calculation. If the World Angle from Entity A to a "northward" Entity B is 192, the A->B World angle will remain 192 regardless of if Entity A is facing North or South.

[[/images/world_angles.png|Diagram of world angles]]

These angles are with Entity A as the "origin". If the World Angle from Entity _B_ to Entity _A_ is measured, it will always be the "cardinal opposite" of Entity A to Entity B (_not_ a negative value).

❕ **Tip:** Because Rotation values and World Angles are both absolutely aligned and on the same scale, having an entity face a given angle (ie: another entity) is as simple as setting the entity's Rotation to the World Angle!

# Facing Angles
Facing Angles are the number of degrees from an entity's Rotation to another entity's World Angle. In other words, they're the number of degrees Entity A would need to turn to face Entity B.

An Entity A > Entity B **Facing Angle of 0 means that Entity A is _directly_ facing Entity B** with no deviation (its Rotation is the same as the A->B World Angle).

As entities can turn in two directions, there would ordinarily be two potential values which could work. However, **the Facing Angle is always the _lower_ of the two values.**

⚠️ **Facing Angles range 0~128. An Entity A > Entity B Facing Angle of 128 means Entity B is directly opposite of where Entity A is facing.**

Additionally, **Facing Angles are signed** to indicate _which_ direction a rotation would need to be to directly face another entity. **Negative values are counter-clockwise turns**, while **positive values are clockwise turns** (matching standard Rotation increases).

[[/images/facing_angles.png|Diagram of facing angles]]

| Facing Value | Shortest Turn Direction | (Standard Trig) Pi | "360 Scale" Degree Turn |
| - | - | - | - |
| -128 | Left | Pi/4 | 180 |
| -96 | Left | 3Pi/4 | 135 |
| -64 | Left | Pi/2 | 90 |
| -32 | Left | Pi/4 | 45 |
| 0 | 0 | 0 | 0 |
| 32 | Right | 7Pi/4 | 45 |
| 64 | Right | 3Pi/2 | 90 | 
| 96 | Right | 5Pi/4 | 135 |
| 128 | Right | Pi | 180 |

# Positional Arcs

The **absolute value** of the Facing Angle can be compared against certain values to quickly determine where Entity B _is_, in relation to where Entity A is _facing_.

⚠️ Remember that **the maximum absolute value of a Facing Angle is _half_ a circle**. Angles to compare against need to be _half_ as well. **Comparisons against these check for _both_ halves of a circle (sides of the mob)**.

[[/images/positional_arcs.png|Diagram of positional arcs]]

| Term | Minimum Absolute Facing Angle | Maximum Absolute Facing Angle | Minimum "360 Scale" Degree | Maximum "360 Scale" Degree |
| - | - | - | - | - |
| In Front | 0 | 32 | 0 | 45 |
| Beside | 32 | 96 | 45 | 135 |
| Behind | 96 | 128 | 135 | 180 |
