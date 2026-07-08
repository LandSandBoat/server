---@meta

xi = xi or {}

---@class xi.test
---@field world CSimulation The global simulation world instance
xi.test = xi.test or {}

---Emits a log message if DEBUG_TEST is enabled.
---@param msg string
---@return nil
function DebugTest(msg)
end

---Emits a log message
---@param msg string
---@return nil
function InfoTest(msg)
end

---Create a new test context
---@param name string Name of the suite
---@param fun function Nested test suites and test cases
---@return nil
function describe(name, fun)
end

---Set a function to be executed before EVERY test in current suite and children suites
---@param fun function Callback to be executed
---@return nil
function before_each(fun)
end

---Set a function to be executed after EVERY test case in current suite and children suites
---@param fun function Callback to be executed
---@return nil
function after_each(fun)
end

---Define a test case
---@param name string Name of the test case
---@param fun function Test function
---@return nil
function it(name, fun)
end

---Set a function to execute ONCE for the current test suite, before test cases.
---@param fun function
---@return nil
function setup(fun)
end

---Set a function to execute ONCE for the current test suite, after test cases.
---@param fun function
---@return nil
function teardown(fun)
end

---Create a spy that wraps and records calls to a global function
---@param path string Dot-separated path to the function (e.g., "xi.spells.damage.calculateDayAndWeather")
---@nodiscard
---@return CSpy
function spy(path)
end

---Create a stub (mock) that replaces a global function
---@param path string Dot-separated path to the function (e.g., "xi.globals.interaction.trade")
---@param impl? function|any Optional implementation or return value
---@nodiscard
---@return CStub
function mock(path, impl)
end

---Create a stub that replaces a global function (alias for mock)
---@param path string Dot-separated path to the function (e.g., "xi.globals.interaction.trade")
---@param impl? function|any Optional implementation or return value
---@return CStub
function stub(path, impl)
end
