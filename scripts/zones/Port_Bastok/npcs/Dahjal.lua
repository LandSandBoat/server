-----------------------------------
-- Area: Port Bastok
--  NPC: Dahjal
-- Member of the traveling troupe. Only appears if Bastok is in 1st and there is NOT a tie
-- !pos 100.612 8.457 -57.677
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local pNation = player:getNation()

    if pNation == xi.nation.BASTOK then
        return player:messageText(npc, ID.text.DAHJAL_BASTOK_CIT)
    else
        return player:messageText(npc, ID.text.DAHJAL_NOT_BASTOK_CIT)
    end
end

return entity
