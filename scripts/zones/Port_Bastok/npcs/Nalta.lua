-----------------------------------
-- Area: Port Bastok
--  NPC: Nalta
-- Member of the traveling troupe. Only appears if Bastok is in 1st and there is NOT a tie
-- !pos 100.612 8.457 -57.677
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
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
