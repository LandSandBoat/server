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

#include "test_matcher.h"
#include "test_suite.h"
#include <filesystem>
#include <optional>
#include <sol/sol.hpp>
#include <string>
#include <vector>

struct FilterConfig;
class ReporterContainer;

class TestCollector
{
public:
    TestCollector(const FilterConfig& filters, ReporterContainer& reporters);

    auto totalTests() const -> size_t;
    auto totalSuites() const -> size_t;
    auto rootSuite() const -> const TestSuite&;

private:
    auto collectTestFiles() const -> std::vector<std::filesystem::path>;
    void loadTestFile(const std::filesystem::path& filePath);
    void registerTestFramework();
    void countTestsAndSuites();
    void countSuite(const TestSuite& suite, int depth);

    TestSuite                       rootSuite_;
    TestSuite*                      currentSuite_;
    TestMatcher                     matcher_;
    ReporterContainer&              reporters_;
    std::string                     currentFile_;
    std::optional<sol::environment> currentEnvironment_;
    size_t                          totalTests_{ 0 };
    size_t                          totalSuites_{ 0 };
};
