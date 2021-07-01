-----------------------------------
-- Area: King Ranperre's Tomb
-- DOOR: _5a0 (Heavy Stone Door)
-- !pos -39.000 4.823 20.000 190
-----------------------------------
local ID = require("scripts/zones/King_Ranperres_Tomb/IDs")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local currentMission = player:getCurrentMission(SANDORIA)
    local missionStatus = player:getMissionStatus(player:getNation())

    if currentMission == xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT and missionStatus == 6 then
        player:startEvent(14)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 14 then
        player:setMissionStatus(player:getNation(), 7)
        -- at this point 3 optional cs are available and open until watched (add 3 var to char?)
    end
end

return entity
