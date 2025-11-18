-----------------------------------
-- Area: Windurst Woods
--  NPC: Mokop-Sankop
-- Member of the traveling troupe. Only appears if Windurst is in 1st and there is NOT a tie
-- !pos 11.542 2.05 -53.217
-----------------------------------
local ID = zones[xi.zone.WINDURST_WOODS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local pNation = player:getNation()

    if pNation == xi.nation.WINDURST then
        return player:messageText(npc, ID.text.MOKOP_WINDY_CIT)
    else
        return player:messageText(npc, ID.text.MOKOP_NOT_WINDY_CIT)
    end
end

return entity
