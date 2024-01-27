-----------------------------------
-- func: checkvar <varType> <varName>
-- desc: checks player or server variable and returns result value.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'ss'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!checkvar { \'server\', or player } <variable name>')
end

commandObj.onTrigger = function(player, arg1, arg2)
    local targ
    local varName

    if arg2 == nil then
        -- no player provided. shift arguments by one.
        targ = nil
        varName = arg1
    else
        targ = arg1
        varName = arg2
    end

    -- validate target
    if targ == nil then
        targ = player:getCursorTarget()
        if targ == nil or not targ:isPC() then
            targ = player
        end
    else
        if string.upper(targ) == 'SERVER' then
            targ = 'server'
        else
            local target = targ
            targ = GetPlayerByName(targ)
            if targ == nil then
                error(player, string.format('Player named "%s" not found!', target))
                return
            end
        end
    end

    -- validate varName
    if varName == nil then
        error(player, 'You must provide a variable name.')
        return
    end

    -- show variable
    if targ == 'server' then
        player:printToPlayer(string.format('Server variable \'%s\' : %u ', varName, GetServerVariable(varName)))
    else
        player:printToPlayer(string.format('%s\'s variable \'%s\' : %u', targ:getName(), varName, targ:getCharVar(varName)))
    end
end

return commandObj
