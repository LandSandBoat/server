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

#include "console_reporter.h"
#include "enums/test_status.h"
#include "test_case.h"
#include "test_suite.h"

#include <fmt/format.h>
#include <iostream>
#include <string_view>
#include <termcolor/termcolor.hpp>

namespace
{

std::string formatDuration(const std::chrono::milliseconds ms)
{
    if (ms.count() < 1000)
    {
        return fmt::format("{} ms", ms.count());
    }

    return fmt::format("{:.3f} s", ms.count() / 1000.0);
}

std::string pluralize(size_t count, const std::string& word)
{
    return fmt::format("{} {}{}", count, word, count != 1 ? "s" : "");
}

} // namespace

ConsoleReporter::ConsoleReporter(const bool verbose)
: verbose_(verbose)
{
}

void ConsoleReporter::onSuiteStart(const TestSuite& suite)
{
    suiteTestCount_ = 0;

    if (verbose_)
    {
        std::cout << termcolor::green << "[----------]" << termcolor::reset << " " << suite.fullName() << '\n';
    }
}

void ConsoleReporter::onSuiteEnd(const TestSuite& suite, std::chrono::milliseconds duration)
{
    if (verbose_)
    {
        std::cout << termcolor::green << "[----------]" << termcolor::reset << " "
                  << pluralize(suiteTestCount_, "test") << " from " << suite.fullName()
                  << " (" << formatDuration(duration) << " total)\n\n";
    }
}

void ConsoleReporter::onTestStart(const TestSuite& suite, const TestCase& testCase)
{
    std::cout << termcolor::green << "[ RUN      ]" << termcolor::reset << " " << suite.fullName() << "::" << testCase.name() << "\n";
}

void ConsoleReporter::onTestSkipped(const TestSuite& suite, const TestCase& testCase)
{
    std::ignore = suite;
    std::ignore = testCase;
    skippedTests_++;
}

void ConsoleReporter::onTestEnd(const TestResult& result)
{
    totalTests_++;
    suiteTestCount_++;

    std::string label;
    using ColorFunc = std::ostream& (*)(std::ostream&);
    ColorFunc color = termcolor::reset;

    switch (result.status)
    {
        case TestStatus::Passed:
            label = "       OK ";
            color = termcolor::green;
            passedTests_++;
            break;
        case TestStatus::Failed:
            label = "  FAILED  ";
            color = termcolor::red;
            failedTests_++;
            failedResults_.push_back(result);
            break;
        case TestStatus::Skipped:
            label = " SKIPPED  ";
            color = termcolor::yellow;
            skippedTests_++;
            break;
        default:
            label = " UNKNOWN  ";
            color = termcolor::reset;
            break;
    }

    // Status line
    std::cout << color << "[" << label << "]" << termcolor::reset << " "
              << result.suiteName << "::" << result.testName
              << " (" << formatDuration(result.duration) << ")\n";

    // Error message
    if (result.status == TestStatus::Failed && !result.errorMessage.empty())
    {
        std::cout << termcolor::red << "  Error: " << result.errorMessage << termcolor::reset << "\n";
    }

    // Logs (on failure or verbose)
    if (!result.logs.empty() && (result.status == TestStatus::Failed || verbose_))
    {
        std::cout << "  Test logs:\n";
        for (const auto& log : result.logs)
        {
            std::string_view sv(log);

            // Trim trailing whitespace, newlines
            if (const auto end = sv.find_last_not_of(" \t\r\n"); end != std::string_view::npos)
            {
                sv = sv.substr(0, end + 1);
                std::cout << fmt::format("    {}\n", sv);
            }
        }
    }
}

void ConsoleReporter::onRunComplete(std::chrono::milliseconds totalDuration)
{
    // Summary header
    std::cout << termcolor::green << "[==========]" << termcolor::reset << " "
              << pluralize(totalTests_, "test") << " ran. ("
              << formatDuration(totalDuration) << " total)\n";

    // Results by status
    if (passedTests_ > 0)
    {
        std::cout << termcolor::green << "[  PASSED  ]" << termcolor::reset << " " << pluralize(passedTests_, "test") << ".\n";
    }

    if (skippedTests_ > 0)
    {
        std::cout << termcolor::yellow << "[ SKIPPED  ]" << termcolor::reset << " " << pluralize(skippedTests_, "test") << ".\n";
    }

    // Failed tests listing
    if (failedTests_ > 0)
    {
        std::cout << termcolor::red << "[  FAILED  ]" << termcolor::reset << " "
                  << pluralize(failedTests_, "test") << ", listed below:\n";

        for (const auto& failure : failedResults_)
        {
            std::cout << termcolor::red << "[  FAILED  ]" << termcolor::reset << " "
                      << failure.suiteName << "::" << failure.testName << '\n';
        }
    }
}
