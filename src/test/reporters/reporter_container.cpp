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

#include "reporter_container.h"

#include "common/logging.h"
#include "reporters/console_reporter.h"
#include "reporters/ctrf_reporter.h"

ReporterContainer::ReporterContainer(bool verbose, const std::string& outputFile)
{
    // Always add console reporter
    reporters_.push_back(std::make_unique<ConsoleReporter>(verbose));

    // Add file reporter if specified
    if (!outputFile.empty())
    {
        if (outputFile.ends_with(".json"))
        {
            reporters_.push_back(std::make_unique<CTRFReporter>(outputFile));
        }
        else
        {
            ShowWarningFmt("Unknown output format: {}. Supported: .json", outputFile);
        }
    }
}

void ReporterContainer::onSuiteStart(const TestSuite& suite) const
{
    for (auto& reporter : reporters_)
    {
        reporter->onSuiteStart(suite);
    }
}

void ReporterContainer::onSuiteEnd(const TestSuite& suite, std::chrono::milliseconds duration) const
{
    for (auto& reporter : reporters_)
    {
        reporter->onSuiteEnd(suite, duration);
    }
}

void ReporterContainer::onTestStart(const TestSuite& suite, const TestCase& testCase) const
{
    for (auto& reporter : reporters_)
    {
        reporter->onTestStart(suite, testCase);
    }
}

void ReporterContainer::onTestEnd(const TestResult& result) const
{
    for (auto& reporter : reporters_)
    {
        reporter->onTestEnd(result);
    }
}

void ReporterContainer::onTestSkipped(const TestSuite& suite, const TestCase& testCase) const
{
    for (auto& reporter : reporters_)
    {
        reporter->onTestSkipped(suite, testCase);
    }
}

void ReporterContainer::onRunComplete(const std::chrono::milliseconds totalDuration) const
{
    for (auto& reporter : reporters_)
    {
        reporter->onRunComplete(totalDuration);
    }
}
