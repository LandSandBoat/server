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

#pragma once

#include <cmath>

namespace xirand::detail
{

/// @brief Standard normal CDF Phi(z): the probability that a standard normal
///        draw lands below z.
/// @note Unlike canonical53's pure-arithmetic construction, this leans on libm
///       (std::erfc), so results are deterministic per platform but may differ
///       in the last few ulps across platforms.
[[nodiscard]] inline auto normalCDF(double z) -> double;

/// @brief Inverse standard normal CDF Phi^-1(p).
/// @note Acklam's rational approximation (~1.15e-9 relative error) followed by one
///       Halley refinement step against normalCDF, giving near machine precision.
/// @param p Probability. Must be strictly inside (0, 1); the function is singular
///          at both endpoints, and callers are expected to clamp before calling.
[[nodiscard]] inline auto inverseNormalCDF(double p) -> double;

} // namespace xirand::detail

//
// inline impls
//

[[nodiscard]] inline auto xirand::detail::normalCDF(const double z) -> double
{
    // Phi(z) = erfc(-z / sqrt(2)) / 2
    return 0.5 * std::erfc(-z * 0.70710678118654752440);
}

[[nodiscard]] inline auto xirand::detail::inverseNormalCDF(const double p) -> double
{
    // ATTR: Coefficients and region structure are Peter Acklam's algorithm for the
    //       inverse normal CDF (2003), a rational approximation in three regions:
    //       https://web.archive.org/web/20151030215612/http://home.online.no/~pjacklam/notes/invnorm/
    constexpr double a[] = { -3.969683028665376e+01, 2.209460984245205e+02, -2.759285104469687e+02, 1.383577518672690e+02, -3.066479806614716e+01, 2.506628277459239e+00 };
    constexpr double b[] = { -5.447609879822406e+01, 1.615858368580409e+02, -1.556989798598866e+02, 6.680131188771972e+01, -1.328068155288572e+01 };
    constexpr double c[] = { -7.784894002430293e-03, -3.223964580411365e-01, -2.400758277161838e+00, -2.549732539343734e+00, 4.374664141464968e+00, 2.938163982698783e+00 };
    constexpr double d[] = { 7.784695709041462e-03, 3.224671290700398e-01, 2.445134137142996e+00, 3.754408661907416e+00 };

    constexpr double pLow  = 0.02425;
    constexpr double pHigh = 1.0 - pLow;

    double x = 0.0;
    if (p < pLow)
    {
        // Lower tail.
        const double q = std::sqrt(-2.0 * std::log(p));

        x = (((((c[0] * q + c[1]) * q + c[2]) * q + c[3]) * q + c[4]) * q + c[5]) /
            ((((d[0] * q + d[1]) * q + d[2]) * q + d[3]) * q + 1.0);
    }
    else if (p <= pHigh)
    {
        // Central region: pure arithmetic, no libm calls.
        const double q = p - 0.5;
        const double r = q * q;

        x = (((((a[0] * r + a[1]) * r + a[2]) * r + a[3]) * r + a[4]) * r + a[5]) * q /
            (((((b[0] * r + b[1]) * r + b[2]) * r + b[3]) * r + b[4]) * r + 1.0);
    }
    else
    {
        // Upper tail: mirror of the lower tail.
        const double q = std::sqrt(-2.0 * std::log(1.0 - p));

        x = -(((((c[0] * q + c[1]) * q + c[2]) * q + c[3]) * q + c[4]) * q + c[5]) /
            ((((d[0] * q + d[1]) * q + d[2]) * q + d[3]) * q + 1.0);
    }

    // One Halley refinement step against the forward CDF. Safe for |x| up to
    // ~26 sigma before exp() overflows; callers clamping p to [2^-53, 1 - 2^-53]
    // keep |x| below ~8.2.
    const double e = normalCDF(x) - p;
    const double u = e * 2.50662827463100050242 * std::exp(0.5 * x * x); // sqrt(2*pi)

    return x - u / (1.0 + 0.5 * x * u);
}
