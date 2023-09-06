-----------------------------------
-- func: exec
-- desc: Allows you to execute a Lua string directly from chat.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 4,
    parameters = 's'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!exec <Lua string>')
end

commandObj.onTrigger = function(player, str)
    -- Ensure a command was given..
    if str == nil or string.len(str) == 0 then
        error(player, 'You must enter a string to execute.')
        return
    end

    -- For safety measures we will nuke the os table..
    local oldOs = os
    os = nil

    -- Define 'player' and 'target' inside the string for use by the caller
    local definePlayer = 'local player = GetPlayerByName(\'' .. player:getName() .. '\'); '
    local defineTarget = 'local target = player:getCursorTarget(); '

    -- Ensure the command compiles / is valid..
    local scriptObj, err0 = loadstring(definePlayer .. defineTarget .. str)
    if scriptObj == nil then
        player:PrintToPlayer('Failed to load the given string.')
        player:PrintToPlayer(err0)
        os = oldOs
        return
    end

    -- Execute the string..
    local successfullyExecuted, errorMessage = pcall(scriptObj)
    if not successfullyExecuted then
        player:PrintToPlayer('Error calling: ' .. str .. '\n' .. errorMessage)
    end

    -- Restore the os table..
    os = oldOs
end

return commandObj
