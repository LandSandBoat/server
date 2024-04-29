-----------------------------------
-- func: wallhack <optional target>
-- desc: Allows the player to walk through walls.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!wallhack (player)')
end

commandObj.onTrigger = function(player, target)
    -- validate target
    local targ
    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    end

    -- toggle wallhack for target
    if targ:getWallhack() then
        targ:setWallhack(false)
        player:printToPlayer(string.format('Toggled %s\'s wallhack flag OFF.', targ:getName()))
    else
        targ:setWallhack(true)
        player:printToPlayer(string.format('Toggled %s\'s wallhack flag ON.', targ:getName()))
    end
end

return commandObj
