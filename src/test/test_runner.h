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

#include "common/application.h"

class WorldServer;
struct TestOptions
{
    std::string              output         = "term";                     // output format, can be "term", "junit"
    bool                     keepGoing      = false;                      // continue as much as possible after an error or failure
    int                      runs           = 1;                          // number of times to run the tests
    bool                     verbose        = false;                      // verbose output of errors
    std::vector<std::string> tags           = {};                         // only run tests with these #tags
    std::vector<std::string> excludeTags    = {};                         // do not run tests with these #tags, takes precedence over tags
    std::vector<std::string> filter         = {};                         // only run test names matching the pattern
    std::vector<std::string> filterOut      = {};                         // do not run test names matching the pattern, takes precedence over filter
    std::vector<std::string> pattern        = { "" };                     // only run test files matching the pattern
    std::vector<std::string> excludePattern = { "" };                     // do not run test files matching the pattern, takes precedence over pattern
    bool                     recursive      = true;                       // recurse into subdirectories
    std::vector<std::string> ROOT           = { "scripts/tests/suites" }; // test script file/folder. Folders will be traversed for any file that matches the pattern option
    std::vector<std::string> name           = {};                         // run test with the given full name
};

class Arguments;
class InMemorySink;
class MapServer;
class TestRunner final : public Application
{
public:
    TestRunner(int argc, char** argv);
    ~TestRunner() override;

    void onArgumentsRegister(Arguments* args) override;
    auto onInitialize() -> bool override;
    auto onRun() -> int override;

    void overrideSettings() const;
    void prepareLuaEnvironment() const;
    bool executeTests();
    void captureLogger() const;

private:
    TestOptions                   m_options;
    std::unique_ptr<MapServer>    m_mapServer; // TODO: Support an array of MapServer to emulate multi-process
    std::unique_ptr<WorldServer>  m_worldServer;
    std::shared_ptr<InMemorySink> m_sink;
};
