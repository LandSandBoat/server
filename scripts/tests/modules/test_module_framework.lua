-----------------------------------
-- Verifies the module framework: expansion chronology, the xi.pre content
-- gate, addOverrideByEra ordering, and the validation of malformed modules.
--
-- See: modules/module_utils.lua
-----------------------------------
describe('Module framework', function()
    -- Module:new appends to the loader's registry; clean the probe back out.
    local function withScratchModule(func)
        local registryBefore = #xi.module.registry
        local m = Module:new('test_module_framework_probe')

        local ok, err = pcall(func, m)

        for i = #xi.module.registry, registryBefore + 1, -1 do
            xi.module.registry[i] = nil
        end

        assert(ok, err)
    end

    -- Takes the function and its arguments, so each expectation stays one line.
    local function expectError(what, func, ...)
        assert(pcall(func, ...) == false, string.format('expected an error: %s', what))
    end

    describe('xi.expansion', function()
        it('is ordered by release date', function()
            local releaseOrder =
            {
                'ROTZ', 'COP', 'TOAU', 'WOTG', 'ACP', 'AMK',
                'ASA', 'ABYSSEA', 'VOIDWATCH', 'SOA', 'ROV', 'TVR',
            }

            for i = 2, #releaseOrder do
                local previous = xi.expansion[releaseOrder[i - 1]]
                local current  = xi.expansion[releaseOrder[i]]

                assert(previous ~= nil, string.format('%s is missing from xi.expansion', releaseOrder[i - 1]))
                assert(current ~= nil, string.format('%s is missing from xi.expansion', releaseOrder[i]))
                assert(current > previous, string.format('%s must sort after %s', releaseOrder[i], releaseOrder[i - 1]))
            end
        end)

        it('covers every ENABLE_ content setting', function()
            for name, _ in pairs(xi.expansion) do
                assert(xi.settings.main['ENABLE_' .. name] ~= nil,
                    string.format('xi.expansion.%s has no ENABLE_%s setting', name, name))
            end
        end)
    end)

    describe('xi.pre', function()
        local savedMain

        before_each(function()
            savedMain = xi.settings.main
        end)

        after_each(function()
            xi.settings.main = savedMain
        end)

        it('is false for every expansion when content is not restricted', function()
            xi.settings.main = { RESTRICT_CONTENT = 0, ENABLE_ABYSSEA = 0 }

            assert(xi.pre(xi.expansion.ABYSSEA) == false, 'restriction off must disable every era gate')
        end)

        it('is true only for content that is disabled', function()
            xi.settings.main =
            {
                RESTRICT_CONTENT = 1,
                ENABLE_TOAU      = 1,
                ENABLE_ABYSSEA   = 0,
            }

            assert(xi.pre(xi.expansion.TOAU) == false, 'enabled content must not gate on')
            assert(xi.pre(xi.expansion.ABYSSEA) == true, 'disabled content must gate on')
        end)

        it('rejects anything that is not an xi.expansion value', function()
            expectError('a bare tag string', xi.pre, 'ABYSSEA')
            expectError('nil', xi.pre, nil)
        end)
    end)

    describe('addOverrideByEra', function()
        it('declares cases newest era first, whatever order they are written in', function()
            withScratchModule(function(m)
                m:addOverrideByEra('xi.test.orderingTarget',
                {
                    [xi.expansion.WOTG] = function()
                    end,

                    [xi.expansion.ROV] = function()
                    end,

                    [xi.expansion.ABYSSEA] = function()
                    end,
                })

                assert(#m.overrides == 3, 'every case must be declared')

                -- The oldest era is declared last, so it wraps the newer reverts.
                local expected = { 'ROV', 'ABYSSEA', 'WOTG' }
                for i, tag in ipairs(expected) do
                    local override = m.overrides[i]
                    assert(override.enabled == xi.pre(xi.expansion[tag]),
                        string.format('case %d should be the %s case', i, tag))
                end
            end)
        end)

        it('rejects malformed cases', function()
            withScratchModule(function(m)
                local validCase =
                {
                    [xi.expansion.ROV] = function()
                    end,
                }

                local bareTagCase =
                {
                    ROV = function()
                    end,
                }

                expectError('no cases', m.addOverrideByEra, m, 'xi.test.t', {})
                expectError('a bare tag key', m.addOverrideByEra, m, 'xi.test.t', bareTagCase)
                expectError('a non-function case', m.addOverrideByEra, m, 'xi.test.t', { [xi.expansion.ROV] = 'nope' })
                expectError('a nil target', m.addOverrideByEra, m, nil, validCase)
            end)
        end)
    end)

    describe('validation', function()
        it('requires a non-empty override target', function()
            withScratchModule(function(m)
                local noop = function()
                end

                expectError('a nil target', m.addOverride, m, nil, noop)
                expectError('an empty target', m.addOverride, m, '', noop)
                expectError('a non-function override', m.addOverride, m, 'xi.test.t', 'nope')
            end)
        end)

        it('requires a boolean gate, so a settings number cannot silently enable a module', function()
            withScratchModule(function(m)
                expectError('a number passed to setEnabled', m.setEnabled, m, 0)
                expectError('a number condition', Module.new, Module, 'test_module_framework_condition', 1)
            end)
        end)
    end)

    describe('registerCommand', function()
        it('stages the command instead of publishing it', function()
            local registryBefore = #xi.module.commandRegistry

            xi.module.registerCommand('test_module_framework_cmd',
            {
                cmdprops = { permission = 1, parameters = '' },
                onTrigger = function()
                end,
            })

            local staged = xi.module.commandRegistry[#xi.module.commandRegistry]
            assert(staged.name == 'test_module_framework_cmd', 'the command name should be staged')
            assert(type(staged.command) == 'table', 'the command table should be staged')
            assert(xi.commands == nil or xi.commands.test_module_framework_cmd == nil,
                'registerCommand must not publish into xi.commands; the loader does that once the file loads cleanly')

            for i = #xi.module.commandRegistry, registryBefore + 1, -1 do
                xi.module.commandRegistry[i] = nil
            end
        end)

        it('rejects a table that is not a command', function()
            local validCommand =
            {
                cmdprops = {},
                onTrigger = function()
                end,
            }

            expectError('no cmdprops or onTrigger', xi.module.registerCommand, 'test_bad', {})
            expectError('an empty name', xi.module.registerCommand, '', validCommand)
        end)
    end)
end)
