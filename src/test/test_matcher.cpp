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

#include "test_matcher.h"
#include "common/logging.h"
#include <format>
#include <regex>

TestMatcher::TestMatcher(FilterConfig config)
: config_(std::move(config))
{
}

// Decide if a file should be skipped based on include/exclude patterns
auto TestMatcher::shouldSkipFile(const std::filesystem::path& filePath) const -> bool
{
    const std::string pathStr = filePath.string();

    // Check exclude patterns first
    if (matchesAnyPattern(pathStr, config_.excludePatterns))
    {
        return true;
    }

    // If include patterns specified, file must match at least one
    if (!config_.includePatterns.empty() && !matchesAnyPattern(pathStr, config_.includePatterns))
    {
        return true;
    }

    return false;
}

// Decide if a test should be skipped based on include/exclude filters and tags
auto TestMatcher::shouldSkipTest(const std::string& fullTestName) const -> bool
{
    // Check exclude tags first
    for (const auto& excludeTag : config_.excludeTags)
    {
        if (hasTag(fullTestName, excludeTag))
        {
            return true;
        }
    }

    // If include tags specified, test must have at least one
    if (!config_.includeTags.empty())
    {
        bool hasIncludeTag = false;
        for (const auto& includeTag : config_.includeTags)
        {
            if (hasTag(fullTestName, includeTag))
            {
                hasIncludeTag = true;
                break;
            }
        }

        if (!hasIncludeTag)
        {
            return true;
        }
    }

    // Check exclude filters
    if (matchesAnyPattern(fullTestName, config_.excludeFilters))
    {
        return true;
    }

    // If include filters specified, test must match at least one
    if (!config_.includeFilters.empty() && !matchesAnyPattern(fullTestName, config_.includeFilters))
    {
        return true;
    }

    return false;
}

// Check if the text matches any of the given regex patterns
auto TestMatcher::matchesAnyPattern(const std::string& text, const std::vector<std::string>& patterns) const -> bool
{
    for (const auto& pattern : patterns)
    {
        try
        {
            if (std::regex regex(pattern); std::regex_search(text, regex))
            {
                return true;
            }
        }
        catch (const std::regex_error& e)
        {
            ShowErrorFmt("Invalid regex pattern '{}': {}", pattern, e.what());
            // Fall back to simple string matching
            if (text.find(pattern) != std::string::npos)
            {
                return true;
            }
        }
    }

    return false;
}

// Check if the test name contains the specified tag (formatted as #tag)
auto TestMatcher::hasTag(const std::string& testName, const std::string& tag) const -> bool
{
    return testName.find(std::format("#{}", tag)) != std::string::npos;
}
