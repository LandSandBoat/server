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

#include <chrono>
#include <string>
#include <vector>

enum class TestStatus : uint8_t;
class TestSuite;
class TestCase;

struct TestResult
{
    std::string               suiteName;
    std::string               testName;
    TestStatus                status;
    std::chrono::milliseconds duration;
    std::string               errorMessage;
    std::vector<std::string>  logs;
    std::string               filePath;
};

class TestReporter
{
public:
    TestReporter()          = default;
    virtual ~TestReporter() = default;

    TestReporter(const TestReporter&)            = delete;
    TestReporter& operator=(const TestReporter&) = delete;
    TestReporter(TestReporter&&)                 = delete;
    TestReporter& operator=(TestReporter&&)      = delete;

    // Suite lifecycle events
    virtual void onSuiteStart(const TestSuite& suite)                                   = 0;
    virtual void onSuiteEnd(const TestSuite& suite, std::chrono::milliseconds duration) = 0;

    // Test lifecycle events
    virtual void onTestStart(const TestSuite& suite, const TestCase& testCase)   = 0;
    virtual void onTestEnd(const TestResult& result)                             = 0;
    virtual void onTestSkipped(const TestSuite& suite, const TestCase& testCase) = 0;

    // Final report generation
    virtual void onRunComplete(std::chrono::milliseconds totalDuration) = 0;
};
