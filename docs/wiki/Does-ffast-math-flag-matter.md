Does `-ffast-math (/fp:fast)` matter? Should we be using it? DSP and a lot of Topaz was using it before the CMake refactor project.
It breaks IEEE compliance. Anecdotal tales of gamedev, and looking at the accuracy of float being used by the game say that this probably doesn't matter.

## Test

- Log in in {Kuftal Tunnel}.
- Aggro and train the first group of crabs.
- Take them around to the left.
- Aggro the second group of crabs.
- Wait for 700-ish samples of ZoneServer tick.

## Results (ZoneServer tick (ms), n=700)

| metric | fastmath OFF | fastmath ON |
|:---:|:---:|:---:|
| Mean | 2.03 | 1.85 |
| Median | 1.62 | 1.64 |
| Mode | 1.51 | 1.34 |
| σ | 2.48 | 1.25 |

## Conclusion

_Maybe_. A larger, longer, and more varied workload would help to determine how useful the flag is. It shall stay on by default 🤷

## Tracy Output

### Windows + sol-refactor + Release Build (-O2) + OFF

![image](https://user-images.githubusercontent.com/1389729/119228877-c811fd80-bb1d-11eb-867a-c5836dfd6118.png)

### Windows + sol-refactor + Release Build (-O2) + ON

![image](https://user-images.githubusercontent.com/1389729/119228888-dfe98180-bb1d-11eb-87a2-d6b9e2305544.png)

## Links

- <https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html>
- <https://stackoverflow.com/questions/7420665/what-does-gccs-ffast-math-actually-do>
