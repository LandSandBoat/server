-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Eliot
-- !pos -103 -26 -49 26
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED) then
        player:sendMenu(xi.menuType.AUCTION)
    else
        player:showText(npc, zones[xi.zone.TAVNAZIAN_SAFEHOLD].text.COMPLETELY_BARE)
    end
end

return entity
