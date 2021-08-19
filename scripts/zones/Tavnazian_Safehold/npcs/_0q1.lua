-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: _0q1 (Sewer Entrance)
-- !pos 28 -12 44 26
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getCurrentMission(COP) == xi.mission.id.cop.THE_LOST_CITY and player:getCharVar("PromathiaStatus") > 0) then
        player:startEvent(103)
    elseif (player:getCurrentMission(COP) == xi.mission.id.cop.CHAINS_AND_BONDS and player:getCharVar("PromathiaStatus") == 3) then
        player:startEvent(116)
    elseif (player:getCurrentMission(COP) >= xi.mission.id.cop.DISTANT_BELIEFS or player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LAST_VERSE)) then
        player:startEvent(502)
    else
        -- player:messageSpecial()
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 103) then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LOST_CITY)
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.DISTANT_BELIEFS)
    elseif (csid == 116) then
        player:setCharVar("PromathiaStatus", 4)
    elseif (csid == 502 and option == 1) then
        player:setPos(260.068, 0, -283.568, 190, 27) -- To Phomiuna Aqueducts {R}
    end
end

return entity
