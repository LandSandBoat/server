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

#include "ctrf_reporter.h"
#include "common/logging.h"
#include "common/version.h"
#include "enums/test_status.h"
#include "test_suite.h"

#include <chrono>
#include <fstream>
#include <utility>

CTRFReporter::CTRFReporter(std::string outputPath)
: outputPath_(std::move(outputPath))
{
    runStartTime_ = std::chrono::system_clock::now();
}

void CTRFReporter::onSuiteStart(const TestSuite& suite)
{
    std::ignore = suite;
}

void CTRFReporter::onSuiteEnd(const TestSuite& suite, std::chrono::milliseconds duration)
{
    std::ignore = suite;
    std::ignore = duration;
}

void CTRFReporter::onTestStart(const TestSuite& suite, const TestCase& testCase)
{
    std::ignore = suite;
    std::ignore = testCase;
}

void CTRFReporter::onTestEnd(const TestResult& result)
{
    results_.push_back(result);
}

void CTRFReporter::onTestSkipped(const TestSuite& suite, const TestCase& testCase)
{
    std::ignore = suite;
    std::ignore = testCase;
    skippedCount_++;
}

void CTRFReporter::onRunComplete(std::chrono::milliseconds totalDuration)
{
    std::ignore           = totalDuration;
    const auto runEndTime = std::chrono::system_clock::now();
    auto       startMs    = std::chrono::duration_cast<std::chrono::milliseconds>(runStartTime_.time_since_epoch()).count();
    auto       stopMs     = std::chrono::duration_cast<std::chrono::milliseconds>(runEndTime.time_since_epoch()).count();

    size_t                passed = 0, failed = 0, skipped = skippedCount_;
    std::vector<CTRFTest> tests;

    for (const auto& result : results_)
    {
        switch (result.status)
        {
            case TestStatus::Passed:
                passed++;
                break;
            case TestStatus::Failed:
                failed++;
                break;
            case TestStatus::Skipped:
                // Already counted in onTestSkipped
                break;
        }

        CTRFTest test{
            .name     = result.testName,
            .status   = result.status == TestStatus::Passed ? "passed" : result.status == TestStatus::Failed ? "failed"
                                                                                                             : "skipped",
            .duration = result.duration.count(),
            .suite    = result.suiteName,
            .filePath = result.filePath,
            .output   = result.logs,
            .trace    = result.status == TestStatus::Failed ? result.errorMessage : ""
        };

        tests.push_back(std::move(test));
    }

    CTRFReport report{
        .results = {
            .tool = {
                "xi_test",
                version::GetVersionString(),
            },
            .summary = {
                .tests   = results_.size(),
                .passed  = passed,
                .failed  = failed,
                .skipped = skipped,
                .pending = 0,
                .other   = 0,
                .start   = startMs,
                .stop    = stopMs,
            },
            .tests = std::move(tests),
        }
    };

    if (std::ofstream file(outputPath_); file.is_open())
    {
        nlohmann::json j = report;
        file << j.dump(2);
        file.close();
    }
    else
    {
        ShowErrorFmt("Failed to open CTRF output file: {}", outputPath_);
    }
}
