-----------------------------------
-- Area: Bastok Mines
--  NPC: Tall Mountain
-- Involved in Quest: Stamp Hunt
-- Finish Mission: Bastok 6-1
-- !pos 71 7 -7 234
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(BASTOK) == xi.mission.id.bastok.RETURN_OF_THE_TALEKEEPER and player:getMissionStatus(player:getNation()) == 3 then
        player:startEvent(182)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 182 then
        finishMissionTimeline(player, 1, csid, option)
    end
end

return entity
