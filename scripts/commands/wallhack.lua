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
    if targ:checkNameFlags(0x00000200) then
        targ:setFlag(0x00000200)
        player:printToPlayer(string.format('Toggled %s\'s wallhack flag OFF.', targ:getName()))
    else
        targ:setFlag(0x00000200)
        player:printToPlayer(string.format('Toggled %s\'s wallhack flag ON.', targ:getName()))
    end
end

return commandObj
