-----------------------------------
-- Area: Windurst Woods
--  NPC: Dahjal
-- Member of the traveling troupe. Only appears if Windurst is in 1st and there is NOT a tie
-- !pos 11.639 2.267 -57.706
-----------------------------------
local ID = zones[xi.zone.WINDURST_WOODS]
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
