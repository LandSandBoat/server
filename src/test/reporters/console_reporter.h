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

#include "test_reporter.h"
#include <chrono>

// Simple reporter printing to console in a style similar to Google Test.
// Outputs in color to terminals that support it.
class ConsoleReporter final : public TestReporter
{
public:
    explicit ConsoleReporter(bool verbose = false);

    void onSuiteStart(const TestSuite& suite) override;
    void onSuiteEnd(const TestSuite& suite, std::chrono::milliseconds duration) override;
    void onTestStart(const TestSuite& suite, const TestCase& testCase) override;
    void onTestEnd(const TestResult& result) override;
    void onTestSkipped(const TestSuite& suite, const TestCase& testCase) override;
    void onRunComplete(std::chrono::milliseconds totalDuration) override;

private:
    bool                    verbose_{};
    size_t                  totalTests_{};
    size_t                  passedTests_{};
    size_t                  failedTests_{};
    size_t                  skippedTests_{};
    size_t                  suiteTestCount_{};
    std::vector<TestResult> failedResults_{};
};
