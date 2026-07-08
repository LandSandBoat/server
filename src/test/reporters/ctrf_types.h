/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include <cstdint>
#include <nlohmann/json.hpp>
#include <string>
#include <vector>

// CTRF (Common Test Result Format)
// https://ctrf.io/docs/full-schema

struct CTRFTool
{
    std::string name;
    std::string version;
};

struct CTRFSummary
{
    size_t  tests;
    size_t  passed;
    size_t  failed;
    size_t  skipped;
    size_t  pending;
    size_t  other;
    int64_t start;
    int64_t stop;
};

struct CTRFTest
{
    std::string              name;
    std::string              status;
    int64_t                  duration;
    std::string              suite;
    std::string              filePath;
    std::vector<std::string> output; // Will be serialized as "stdout" in JSON
    std::string              trace;
};

struct CTRFResults
{
    CTRFTool              tool;
    CTRFSummary           summary;
    std::vector<CTRFTest> tests;
};

struct CTRFReport
{
    std::string reportFormat{ "CTRF" };
    std::string specVersion{ "0.0.0" };
    CTRFResults results;
};

// cppcheck-suppress unknownMacro
NLOHMANN_DEFINE_TYPE_NON_INTRUSIVE(CTRFTool, name, version)
// cppcheck-suppress unknownMacro
NLOHMANN_DEFINE_TYPE_NON_INTRUSIVE(CTRFSummary, tests, passed, failed, skipped, pending, other, start, stop)

// Custom serialization for CTRFTest to map 'output' to 'stdout' in JSON
inline void to_json(nlohmann::json& j, const CTRFTest& t)
{
    j = nlohmann::json{
        { "name", t.name },
        { "status", t.status },
        { "duration", t.duration },
        { "suite", t.suite },
        { "filePath", t.filePath },
        { "stdout", t.output }, // Map C++ 'output' field to JSON 'stdout'
        { "trace", t.trace }
    };
}

inline void from_json(const nlohmann::json& j, CTRFTest& t)
{
    j.at("name").get_to(t.name);
    j.at("status").get_to(t.status);
    j.at("duration").get_to(t.duration);
    j.at("suite").get_to(t.suite);
    j.at("filePath").get_to(t.filePath);
    if (j.contains("stdout"))
    {
        j.at("stdout").get_to(t.output);
    }
    j.at("trace").get_to(t.trace);
}

NLOHMANN_DEFINE_TYPE_NON_INTRUSIVE(CTRFResults, tool, summary, tests)
NLOHMANN_DEFINE_TYPE_NON_INTRUSIVE(CTRFReport, reportFormat, specVersion, results)
