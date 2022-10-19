#ifndef _AUTOTRANSLATE_H
#define _AUTOTRANSLATE_H

#include <string>

namespace autotranslate
{
    // Returns a string where the autotranslate raw bytes have been replaced with a sane string value.
    std::string replaceBytes(std::string const& str);
} // namespace autotranslate
#endif // _AUTOTRANSLATE_H
