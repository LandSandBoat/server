#pragma once

#include <string>

namespace autotranslate
{
    // Returns a string where the autotranslate raw bytes have been replaced with a sane string value.
    std::string replaceBytes(std::string const& str);
} // namespace autotranslate
