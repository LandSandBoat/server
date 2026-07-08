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

#include "logging.h"

#include "common/logging_context.h"
#include <fmt/chrono.h>

#include <chrono>
#include <iterator>
#include <span>
#include <utility>

namespace
{

struct JsonStr
{
    std::string_view s;
};

auto basename(std::string_view file) -> std::string_view
{
    const auto slash = file.find_last_of("/\\");
    return slash == std::string_view::npos ? file : file.substr(slash + 1);
}

} // namespace

template <>
struct fmt::formatter<JsonStr>
{
    static constexpr auto parse(format_parse_context& ctx)
    {
        return ctx.begin();
    }

    static auto format(const JsonStr& v, format_context& ctx) -> format_context::iterator
    {
        auto out = ctx.out();
        for (unsigned char c : v.s)
        {
            switch (c)
            {
                case '"':
                    out = fmt::format_to(out, R"(\")");
                    break;
                case '\\':
                    out = fmt::format_to(out, R"(\\)");
                    break;
                case '\b':
                    out = fmt::format_to(out, R"(\b)");
                    break;
                case '\f':
                    out = fmt::format_to(out, R"(\f)");
                    break;
                case '\n':
                    out = fmt::format_to(out, R"(\n)");
                    break;
                case '\r':
                    out = fmt::format_to(out, R"(\r)");
                    break;
                case '\t':
                    out = fmt::format_to(out, R"(\t)");
                    break;
                default:
                    if (c < 0x20)
                    {
                        out = fmt::format_to(out, R"(\u{:04x})", c);
                    }
                    else
                    {
                        *out++ = static_cast<char>(c);
                    }
            }
        }
        return out;
    }
};

namespace
{

void appendFieldValue(fmt::memory_buffer& buf, const logging::Field::Value& value);

void appendFields(fmt::memory_buffer& buf, std::span<const logging::Field> fields)
{
    auto out   = std::back_inserter(buf);
    bool first = true;
    for (const auto& f : fields)
    {
        if (!std::exchange(first, false))
        {
            buf.push_back(',');
        }
        fmt::format_to(out, R"("{}":)", JsonStr{ f.key });
        appendFieldValue(buf, f.value);
    }
}

void appendFieldValue(fmt::memory_buffer& buf, const logging::Field::Value& value)
{
    auto out = std::back_inserter(buf);
    std::visit(
        [&]<typename T>(const T& v)
        {
            if constexpr (std::is_same_v<T, std::string> || std::is_same_v<T, std::string_view>)
            {
                fmt::format_to(out, R"("{}")", JsonStr{ v });
            }
            else if constexpr (std::is_same_v<T, logging::Subfields>)
            {
                buf.push_back('{');
                appendFields(buf, v);
                buf.push_back('}');
            }
            else
            {
                fmt::format_to(out, "{}", v);
            }
        },
        value);
}

} // namespace

void logging::detail::renderJsonLine(fmt::memory_buffer& buf, const LogRecord& rec)
{
    const auto now    = std::chrono::system_clock::now();
    const auto secs   = std::chrono::time_point_cast<std::chrono::seconds>(now);
    const auto millis = std::chrono::duration_cast<std::chrono::milliseconds>(now - secs).count();
    const auto tt     = std::chrono::system_clock::to_time_t(secs);

    fmt::format_to(std::back_inserter(buf),
                   R"({{"ts":"{:%Y-%m-%dT%H:%M:%S}.{:03d}Z",)"
                   R"("lvl":"{}",)"
                   R"("source":{{"file":"{}","line":{},"function":"{}"}},)"
                   R"("msg":"{}")",
                   fmt::gmtime(tt),
                   static_cast<int>(millis),
                   JsonStr{ rec.levelName },
                   JsonStr{ basename(rec.file) },
                   rec.line,
                   JsonStr{ rec.function },
                   JsonStr{ rec.msg });

    if (const auto& ctx = logging::currentContext(); !ctx.empty())
    {
        buf.push_back(',');
        appendFields(buf, ctx);
    }

    buf.push_back('}');
}
