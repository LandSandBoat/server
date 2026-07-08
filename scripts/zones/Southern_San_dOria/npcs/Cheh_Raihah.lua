-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Cheh Raihah
-- Member of the traveling troupe. Only appears if Bastok is in 1st and there is NOT a tie
-- !pos -18.032 2.000 -12.757
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
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
