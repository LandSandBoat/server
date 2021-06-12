-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Arnau
-- Involved in Mission: Save the Children
-- !pos 148 0 139 231
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getCurrentMission(COP) == xi.mission.id.cop.THE_ROAD_FORKS and player:getCharVar("EMERALD_WATERS_Status") == 2) then
        player:startEvent(51) --COP event
    else
        player:startEvent(20)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 51) then
        player:setCharVar("EMERALD_WATERS_Status", 3)
    end
end

return entity
