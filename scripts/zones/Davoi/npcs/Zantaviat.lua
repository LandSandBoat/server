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

    if (currentMission == xi.mission.id.sandoria.THE_DAVOI_REPORT and player:getMissionStatus(player:getNation()) == 0) then
        player:startEvent(100)
    elseif (currentMission == xi.mission.id.sandoria.THE_DAVOI_REPORT and player:hasKeyItem(xi.ki.LOST_DOCUMENT)) then
        player:startEvent(104)
    elseif (currentMission == xi.mission.id.sandoria.INFILTRATE_DAVOI and infiltrateDavoi and player:getMissionStatus(player:getNation()) == 0) then
        player:startEvent(102)
    elseif (currentMission == xi.mission.id.sandoria.INFILTRATE_DAVOI and player:getMissionStatus(player:getNation()) == 9) then
        player:startEvent(105)
    else
        player:startEvent(101)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 100) then
        player:setMissionStatus(player:getNation(), 1)
    elseif (csid == 104) then
        player:setMissionStatus(player:getNation(), 3)
        player:delKeyItem(xi.ki.LOST_DOCUMENT)
        player:addKeyItem(xi.ki.TEMPLE_KNIGHTS_DAVOI_REPORT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.TEMPLE_KNIGHTS_DAVOI_REPORT)
    elseif (csid == 102) then
        player:setMissionStatus(player:getNation(), 6)
    elseif (csid == 105) then
        player:setMissionStatus(player:getNation(), 10)
        player:delKeyItem(xi.ki.EAST_BLOCK_CODE)
        player:delKeyItem(xi.ki.SOUTH_BLOCK_CODE)
        player:delKeyItem(xi.ki.NORTH_BLOCK_CODE)
    end

end

return entity
