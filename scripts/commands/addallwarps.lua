-----------------------------------
-- func: addallwarps
-- desc: Adds all Survival Guides and Home Points to GM if no target is specified.
-----------------------------------
---@type TCommand
require('scripts/globals/teleports')
xi = xi or {}
xi.survivalGuide = xi.survivalGuide or {}
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!addallwarps (player)')
end

commandObj.onTrigger = function(player, target, zoneId, text, guide)
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

    -- add all Survival Guides
    for i = 1, 32 do
        local groupIndex = i
        local group = 1
        while group < 4 do
            targ:addTeleport(xi.teleport.type.SURVIVAL, groupIndex - 1, group - 1)
            group = group + 1
        end
    end

    -- add all Home Points
    for i = 0, 121 do
        local hpBit = i % 32
        local hpSet = math.floor(i / 32)
        targ:addTeleport(xi.teleport.type.HOMEPOINT, hpBit, hpSet)
    end

    player:printToPlayer(string.format('%s now has all Warps.', targ:getName()))
end

return commandObj
