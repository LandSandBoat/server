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

#include <filesystem>
#include <string>
#include <vector>

struct FilterConfig
{
    // File filtering
    std::vector<std::string> includePatterns; // Regex patterns for files to include
    std::vector<std::string> excludePatterns; // Regex patterns for files to exclude

    // Test filtering
    std::vector<std::string> includeFilters; // Regex patterns for tests to include
    std::vector<std::string> excludeFilters; // Regex patterns for tests to exclude

    // Tag-based filtering
    std::vector<std::string> includeTags; // Tags that tests must have
    std::vector<std::string> excludeTags; // Tags that will exclude tests
};

class TestMatcher
{
public:
    explicit TestMatcher(FilterConfig config);

    auto shouldSkipFile(const std::filesystem::path& filePath) const -> bool;
    auto shouldSkipTest(const std::string& fullTestName) const -> bool;

private:
    auto matchesAnyPattern(const std::string& text, const std::vector<std::string>& patterns) const -> bool;
    auto hasTag(const std::string& testName, const std::string& tag) const -> bool;

    FilterConfig config_;
};
