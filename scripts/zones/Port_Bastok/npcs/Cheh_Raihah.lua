-----------------------------------
-- Area: Port Bastok
--  NPC: Cheh Raihah
-- Member of the traveling troupe. Only appears if Bastok is in 1st and there is NOT a tie
-- !pos 100.612 8.457 -57.677
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local pNation = player:getNation()

    if pNation == xi.nation.WINDURST then
        return player:messageText(npc, ID.text.CHEH_WINDY_CIT)
    else
        return player:messageText(npc, ID.text.CHEH_NOT_WINDY_CIT)
    end
end

return entity
