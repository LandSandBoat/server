-----------------------------------
-- func: exec
-- desc: Allows you to execute a Lua string directly from chat.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 4,
    parameters = 's'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!exec <Lua string>')
end

commandObj.onTrigger = function(player, str)
    if
        not str or
        str == ''
    then
        error(player, 'You must enter a string to execute.')
        return
    end

    --
    -- Set up a safe environment for us to execute the incoming Lua string in
    --

    -- Capture things from the current or global scope we might want in the sandbox.
    local safeEnv =
    {
        player = player,
        target = player:getCursorTarget()
    }

    setmetatable(safeEnv, {
        __index = function(_, key)
            -- Block the use of powerful libraries
            if
                key == 'os' or
                key == 'io' or
                key == 'debug' or
                key == 'require'
            then
                player:printToPlayer('Trying to access forbidden global!')
                return nil
            end

            -- Otherwise, let them through
            return _G[key]
        end
    })

    local scriptObj, compileErr = loadstring(str)
    if not scriptObj then
        player:printToPlayer(fmt('Failed to load string: {}', tostring(compileErr)))
        return
    end

    -- Bind the sandboxed environment to the compiled function.
    setfenv(scriptObj, safeEnv)

    local success, execErr = pcall(scriptObj)
    if not success then
        player:printToPlayer(fmt('Error executing: {}', tostring(execErr)))
    end
end

return commandObj
