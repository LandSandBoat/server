-----------------------------------
-- Area: Windurst Woods
--  NPC: Nalta
-- Member of the traveling troupe. Only appears if Windurst is in 1st and there is NOT a tie
-- !pos 19.14 2.0 -51.297
-----------------------------------
local ID = zones[xi.zone.WINDURST_WOODS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local pNation = player:getNation()

    if pNation == xi.nation.SANDORIA then
        return player:messageText(npc, ID.text.NALTA_SANDY_CIT)
    else
        return player:messageText(npc, ID.text.NALTA_NOT_SANDY_CIT)
    end
end

return entity
