-----------------------------------
-- Area: Zeruhn Mines
--  NPC: Drake Fang
-- Involved in Mission: Bastok 6-1, 8-2
-- !pos -74 0.1 58 172
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local currentMission = player:getCurrentMission(BASTOK)
    local MissionStatus = player:getCharVar("MissionStatus")

    -- Enter the Talekeeper 8-2
    if currentMission == xi.mission.id.bastok.ENTER_THE_TALEKEEPER and MissionStatus == 4 then
        player:startEvent(204)
    elseif currentMission == xi.mission.id.bastok.ENTER_THE_TALEKEEPER and MissionStatus > 1 and MissionStatus < 4 then
        player:startEvent(203)
    elseif currentMission == xi.mission.id.bastok.ENTER_THE_TALEKEEPER and MissionStatus == 0 then
        player:startEvent(202)
    -- Return of the Talekeeper 6-1
    elseif currentMission == xi.mission.id.bastok.RETURN_OF_THE_TALEKEEPER and MissionStatus > 1 then
        player:startEvent(201)
    elseif currentMission == xi.mission.id.bastok.RETURN_OF_THE_TALEKEEPER and MissionStatus == 1 then
        player:startEvent(200)
    else
        player:startEvent(108)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 200 then
        player:setCharVar("MissionStatus", 2)
    elseif csid == 202 then
        player:setCharVar("Missionstatus", 1)
    elseif csid == 204 then
        player:setCharVar("Missionstatus", 5)
        player:delKeyItem(xi.ki.OLD_PIECE_OF_WOOD)
        player:setPos(23, 0, 4)
    end
end

return entity
