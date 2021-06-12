-----------------------------------
-- Area: Davoi
--  NPC: Zantaviat
-- Involved in Mission: The Davoi Report
-- !pos 215 0.1 -10 149
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Davoi/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local currentMission = player:getCurrentMission(SANDORIA)
    local infiltrateDavoi = player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.INFILTRATE_DAVOI)

    if currentMission == xi.mission.id.sandoria.INFILTRATE_DAVOI and infiltrateDavoi and player:getMissionStatus(player:getNation()) == 0 then
        player:startEvent(102)
    elseif currentMission == xi.mission.id.sandoria.INFILTRATE_DAVOI and player:getMissionStatus(player:getNation()) == 9 then
        player:startEvent(105)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 102 then
        player:setMissionStatus(player:getNation(), 6)
    elseif csid == 105 then
        player:setMissionStatus(player:getNation(), 10)
        player:delKeyItem(xi.ki.EAST_BLOCK_CODE)
        player:delKeyItem(xi.ki.SOUTH_BLOCK_CODE)
        player:delKeyItem(xi.ki.NORTH_BLOCK_CODE)
    end
end

return entity
