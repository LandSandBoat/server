-----------------------------------
-- func: addallhp
-- desc: Adds all Home Points to GM if no target is specified.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!addallhp (player)')
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
    -- adds all Home Points
    for i = 0, 121 do
        local hpBit = i % 32
        local hpSet = math.floor(i / 32)
        targ:addTeleport(xi.teleport.type.HOMEPOINT, hpBit, hpSet)
    end
    player:printToPlayer(string.format('%s now has all Home Points.', targ:getName()))
end

return commandObj
