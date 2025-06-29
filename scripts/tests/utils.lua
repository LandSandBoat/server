local utils =
{
    getEnumKey = function(enumTable, value)
        for key, enumValue in pairs(enumTable) do
            if enumValue == value then
                return string.format('%s (%d)', key, value)
            end
        end

        return value
    end,

    ---@param mob CBaseEntity
    respawnDeadMob = function(mob)
        xi.test.world:tickEntity(mob) -- Trigger death
        xi.test.world:skipTime(1)     -- Wait for mob to die
        xi.test.world:tickEntity(mob) -- Trigger post-death

        xi.test.world:skipTime(15)    -- Wait for despawn
        xi.test.world:tickEntity(mob) -- Trigger despawn
        xi.test.world:skipTime(4)     -- Wait for despawn to finish
        xi.test.world:tickEntity(mob) -- Finish despawn
        assert(not mob:isSpawned(),
            string.format('%s did not despawn. Current state is: %u', mob:getName(), mob:getCurrentAction()))
        mob:spawn()
    end,

    ---@param baseTable table Table where the target function is located
    ---@param funcName string Name of the function to mock in the table
    ---@param replacement function The replacement function to use
    ---@param testContext fun(spy: luassert.spy.assert) Code block to execute with the mocked function
    mock = function(baseTable, funcName, replacement, testContext)
        local spy = require('luassert.spy')

        -- Store the original function
        local original = baseTable[funcName]

        -- Replace with the new function
        local spiedFunc = spy.new(replacement)
        baseTable[funcName] = spiedFunc

        local assertedSpy = assert.spy(spiedFunc)

        -- Execute code block with error handling
        local success, result = pcall(testContext, assertedSpy)

        -- Restore original function
        baseTable[funcName] = original

        -- Handle results
        if success then
            -- If the code executed successfully but the spy was never called, this is an error
            assertedSpy.was.called(1)
            return result
        else
            error(result)
        end
    end,
}

return utils
