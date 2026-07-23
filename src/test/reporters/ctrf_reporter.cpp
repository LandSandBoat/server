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
#include "ctrf_types.h"
#include "enums/test_status.h"
#include "test_suite.h"
#include <nlohmann/json.hpp>

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

    const auto statusToString = [](const TestStatus status) -> std::string
    {
        switch (status)
        {
            case TestStatus::Passed:
                return "passed";
            case TestStatus::Failed:
                return "failed";
            case TestStatus::Skipped:
                return "skipped";
        }

        return "other";
    };

    size_t                passed = 0, failed = 0, skipped = skippedCount_, flaky = 0;
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

        if (result.flaky)
        {
            flaky++;
        }

        std::vector<CTRFRetryAttempt> retryAttempts;
        for (size_t i = 0; i < result.retryAttempts.size(); ++i)
        {
            const auto& attempt = result.retryAttempts[i];
            retryAttempts.push_back({
                .attempt  = i + 1, // 1 = first execution
                .status   = statusToString(attempt.status),
                .duration = attempt.duration.count(),
                .message  = attempt.status == TestStatus::Failed ? attempt.errorMessage : "",
            });
        }

        CTRFTest test{
            .name          = result.testName,
            .status        = statusToString(result.status),
            .duration      = result.duration.count(),
            .suite         = result.suiteName,
            .filePath      = result.filePath,
            .output        = result.logs,
            .trace         = result.status == TestStatus::Failed ? result.errorMessage : "",
            .flaky         = result.flaky,
            .retries       = result.retries,
            .retryAttempts = std::move(retryAttempts),
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
                .flaky   = flaky,
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
