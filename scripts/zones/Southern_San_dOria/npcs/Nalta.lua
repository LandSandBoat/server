-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Nalta
-- Member of the traveling troupe. Only appears if Bastok is in 1st and there is NOT a tie
-- !pos -18.032 2.000 -12.757
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
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
