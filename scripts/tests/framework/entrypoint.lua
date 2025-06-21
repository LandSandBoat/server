-----------------------------------
-- xi_test entrypoint
-----------------------------------
require('scripts/tests/assertions/player')
require('scripts/tests/assertions/quest')
require('scripts/tests/packet_builder')
require('scripts/tests/simulation_client')
require('scripts/tests/simulation_world')
local colors = require 'term.colors'

xi = xi or {}
xi.test = xi.test or {}

---@class EntryPointOptions
---@field keepGoing boolean Keep going on errors
---@field verbose boolean Print extended stacktraces on failures
---@field output 'term' | 'junit' | 'json' Output format
---@field tags string[] Filter on given tags
---@field excludeTags string[] Exclude tests with these tags
---@field filter string Filter on test names
---@field name string Filter on full test names
---@field filterOut string Filter out tests with these names
---@field pattern string[] File patterns to match
---@field excludePattern string[] File patterns to exclude
---@field ROOT string[] Root directories with tests
---@field runs integer Number of times to run the tests

---Testing entrypoint for xi_test. Defers to busted
---@param simulation CSimulation
---@param options EntryPointOptions
local function entrypoint(simulation, options)
    xi.test.world            = SimulationWorld:new(simulation)

    -- Have to explicitely bust the cache, else busted will not re-run.
    package.loaded['busted'] = nil

    local busted             = require 'busted.core' ()
    local filterLoader       = require 'busted.modules.filter_loader' ()

    require 'busted' (busted)

    -- lazy setup/teardown: dont run if no matching tests
    busted.register('setup', 'lazy_setup')
    busted.register('teardown', 'lazy_teardown')

    -- watch for test errors and failures
    local failures    = 0
    local errors      = 0
    local quitOnError = not options.keepGoing

    busted.subscribe({ 'error' }, function(element, parent, message)
        errors = errors + 1
        busted.skipAll = quitOnError

        return nil, true
    end)

    busted.subscribe({ 'failure' }, function(element, parent, message)
        if element.descriptor == 'it' then
            failures = failures + 1
        else
            errors = errors + 1
        end

        busted.skipAll = quitOnError

        io.write(colors.red(string.format('Logs for test %s', colors.bright(element.name))), '\n\n')
        for _, log in ipairs(simulation:getLogs()) do
            local cleaned = log:gsub('\r\n+$', '')
            if cleaned ~= '' then
                io.write(colors.red(cleaned), '\n')
            end
        end

        io.flush()

        return nil, true
    end, { priority = 1 })

    -- Initialize output format
    require('scripts/tests/framework/outputs')(busted, options.output, options.verbose)

    -- All tests in a file can share the same simulation world
    busted.subscribe({ 'file', 'end' }, function(file)
        simulation:clean()
    end)

    busted.subscribe({ 'test', 'end' }, function(test, parent, status)
        -- Reset seed in case it was forced by a test
        simulation:seed()

        -- Clear buffered logs
        simulation:clearLogs()
    end)

    -- Pre-load the LuaJIT 'ffi' module if applicable
    require 'busted.luajit' ()

    -- Load tag and test filters
    filterLoader(busted,
        {
            tags             = options.tags,
            excludeTags      = options.excludeTags,
            filter           = options.filter,
            name             = options.name,
            filterOut        = options.filterOut,
            excludeNamesFile = nil,
            list             = false,
            nokeepgoing      = not options.keepGoing,
            suppressPending  = false,
        })

    -- Load test directories/files
    local rootFiles      = options.ROOT
    local patterns       = options.pattern
    local testFileLoader = require 'busted.modules.test_file_loader' (busted, { 'lua' })

    testFileLoader(rootFiles, patterns,
        {
            excludes  = options.excludePattern,
            verbose   = options.verbose,
            recursive = true,
        })

    local execute = require 'busted.execute' (busted)
    execute(options.runs, {})

    busted.publish({ 'exit' })

    return
    {
        failures = failures,
        errors   = errors,
    }
end

return entrypoint
