/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

//
// Compile-time uniformity tests for the RNG. Everything here is
// consteval, so seeding, drawing, and histogramming happen entirely during
// compilation: the static_asserts below fail the build if the spread is skewed.
// This translation unit emits no runtime code; it is linked into xi_test purely
// so the compiler evaluates the checks.
//

#include <common/rng/detail/bounded_int.h>
#include <common/rng/detail/canonical_float.h>
#include <common/rng/squirrel5.h>

#include <array>
#include <cstdint>

namespace xirand::test
{

// Largest absolute deviation of any bucket from the ideal uniform count.
template <std::size_t Buckets>
[[nodiscard]] consteval auto worstDeviation(const std::array<std::uint32_t, Buckets>& histogram, std::uint32_t ideal) -> std::uint32_t
{
    std::uint32_t worst = 0;
    for (const std::uint32_t count : histogram)
    {
        const std::uint32_t deviation = count > ideal ? count - ideal : ideal - count;
        worst                         = deviation > worst ? deviation : worst;
    }

    return worst;
}

// Integer path: seeds a fresh engine, draws Samples values in [0, Buckets) via
// bounded32, and returns the worst bucket deviation. Small relative to
// Samples/Buckets == even spread.
template <std::uint32_t Buckets, std::uint32_t Samples, typename Engine = Squirrel5>
[[nodiscard]] consteval auto maxBucketDeviation(std::uint32_t seed) -> std::uint32_t
{
    static_assert(Buckets > 0, "need at least one bucket");
    static_assert(Samples >= Buckets, "need at least one expected sample per bucket");

    std::array<std::uint32_t, Buckets> histogram{};

    Engine g(seed);
    for (std::uint32_t i = 0; i < Samples; ++i)
    {
        ++histogram[detail::bounded32(g, Buckets)];
    }

    return worstDeviation(histogram, Samples / Buckets);
}

// Float path: same idea, but draws canonical53 (a double in [0, 1)) and buckets by
// unit * Buckets. Exercises canonical53 rather than bounded32.
template <std::uint32_t Buckets, std::uint32_t Samples, typename Engine = Squirrel5>
[[nodiscard]] consteval auto maxCanonicalBucketDeviation(std::uint32_t seed) -> std::uint32_t
{
    static_assert(Buckets > 0, "need at least one bucket");
    static_assert(Samples >= Buckets, "need at least one expected sample per bucket");

    std::array<std::uint32_t, Buckets> histogram{};

    Engine g(seed);
    for (std::uint32_t i = 0; i < Samples; ++i)
    {
        const double unit = detail::canonical53(g); // [0, 1)
        ++histogram[static_cast<std::uint32_t>(unit * Buckets)];
    }

    return worstDeviation(histogram, Samples / Buckets);
}

// True when every bucket lands within tolerancePermille (parts per thousand) of the
// ideal uniform count for the given seed.
template <std::uint32_t Buckets, std::uint32_t Samples, typename Engine = Squirrel5>
[[nodiscard]] consteval auto spreadWithin(std::uint32_t seed, std::uint32_t tolerancePermille) -> bool
{
    const std::uint32_t ideal   = Samples / Buckets;
    const std::uint32_t allowed = static_cast<std::uint32_t>((static_cast<std::uint64_t>(ideal) * tolerancePermille) / 1000u);

    return maxBucketDeviation<Buckets, Samples, Engine>(seed) <= allowed;
}

template <std::uint32_t Buckets, std::uint32_t Samples, typename Engine = Squirrel5>
[[nodiscard]] consteval auto canonicalSpreadWithin(std::uint32_t seed, std::uint32_t tolerancePermille) -> bool
{
    const std::uint32_t ideal   = Samples / Buckets;
    const std::uint32_t allowed = static_cast<std::uint32_t>((static_cast<std::uint64_t>(ideal) * tolerancePermille) / 1000u);

    return maxCanonicalBucketDeviation<Buckets, Samples, Engine>(seed) <= allowed;
}

//
// Compile-time self-tests: the default engine must spread evenly for seed 0xDEADBEEF.
// Over Samples draws into Buckets the per-bucket standard deviation is
// ~sqrt(Samples * (1/Buckets) * (1 - 1/Buckets)); the tolerances below sit ~4.7 sigma
// out, so a failure means a real distribution bug, not noise.
//
// Sample counts are chosen so each static_assert fits the stock constexpr-step budget
// with margin (int ceiling ~29k, float ~19k); no CMake step-budget bump is required.
//

inline constexpr std::uint32_t kIntSamples   = 24000; // 10 buckets -> 1 sigma ~1.9%
inline constexpr std::uint32_t kFloatSamples = 14000; // 10 buckets -> 1 sigma ~2.5%

static_assert(spreadWithin<10, kIntSamples>(0xDEADBEEF, 90), "integer spread too skewed");           // within 9%
static_assert(canonicalSpreadWithin<10, kFloatSamples>(0xDEADBEEF, 120), "float spread too skewed"); // within 12%

} // namespace xirand::test
