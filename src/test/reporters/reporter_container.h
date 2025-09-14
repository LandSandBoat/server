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

#include "reporters/test_reporter.h"
#include <chrono>
#include <memory>
#include <string>
#include <vector>

class ReporterContainer
{
public:
    explicit ReporterContainer(bool verbose = false, const std::string& outputFile = "");

    void onSuiteStart(const TestSuite& suite) const;
    void onSuiteEnd(const TestSuite& suite, std::chrono::milliseconds duration) const;
    void onTestStart(const TestSuite& suite, const TestCase& testCase) const;
    void onTestEnd(const TestResult& result) const;
    void onTestSkipped(const TestSuite& suite, const TestCase& testCase) const;
    void onRunComplete(std::chrono::milliseconds totalDuration) const;

private:
    std::vector<std::unique_ptr<TestReporter>> reporters_;
};
