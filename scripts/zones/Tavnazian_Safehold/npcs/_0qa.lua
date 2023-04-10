-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: walnut door
-- Involved in mission 2-4
-- !pos 111 -41 41 26
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.DAWN and
        player:getCharVar("PromathiaStatus") == 5
    then
        player:startEvent(543)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 543 then
        player:setCharVar("PromathiaStatus", 6)
    end
end

return entity
