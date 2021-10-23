-----------------------------------
-- Area: Heavens Tower
--  NPC: Zubaba
-- Involved in Mission 3-2
-- !pos 15 -27 18 242
-----------------------------------
local ID = require("scripts/zones/Heavens_Tower/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local missionStatus = player:getMissionStatus(player:getNation())

    if player:hasKeyItem(xi.ki.STAR_CRESTED_SUMMONS_1) then
        player:startEvent(157)
    elseif
        player:getCurrentMission(WINDURST) == xi.mission.id.windurst.MOON_READING and
        (missionStatus >= 3 or player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.MOON_READING))
    then
        player:startEvent(387)
    else
        player:startEvent(56)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 387 then
        player:setCharVar("WindurstSecured", 0)
    end
end

return entity
