-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: walnut door
-- Involved in mission 2-4
-- !pos 111 -41 41 26
-----------------------------------
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getCurrentMission(COP) == xi.mission.id.cop.CHAINS_AND_BONDS and player:getCharVar("PromathiaStatus")==4) then
        player:startEvent(115)
    elseif (player:getCurrentMission(COP) == xi.mission.id.cop.DAWN and player:getCharVar("PromathiaStatus")==5) then
        player:startEvent(543)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 115) then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.CHAINS_AND_BONDS)
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.FLAMES_IN_THE_DARKNESS)
    elseif (csid == 543) then
        player:setCharVar("PromathiaStatus", 6)
    end
end

return entity
