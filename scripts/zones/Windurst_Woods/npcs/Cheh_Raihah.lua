-----------------------------------
-- Area: Windurst Woods
--  NPC: Cheh Raihah
-- Member of the traveling troupe. Only appears if Windurst is in 1st and there is NOT a tie
-- !pos 13.191 2.0 -52.66
-----------------------------------
local ID = zones[xi.zone.WINDURST_WOODS]
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
