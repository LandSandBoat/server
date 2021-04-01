-----------------------------------
-- Area: Bastok Mines
--  NPC: Davyad
-- Involved in Mission: Bastok 3-2
-- !pos 83 0 30 234
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getCurrentMission(BASTOK) == xi.mission.id.bastok.TO_THE_FORSAKEN_MINES) then
        player:startEvent(54)
    else
        player:startEvent(53)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
