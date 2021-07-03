-----------------------------------
-- Area: Chateau d'Oraguille
-- Door: Great Hall
-- Involved in Missions: 3-3, 5-2, 6-1, 8-2, 9-1
-- !pos 0 -1 13 233
-----------------------------------
local ID = require("scripts/zones/Chateau_dOraguille/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- This NPC is relevant only to San d'Orians on missions
    if player:getNation() == xi.nation.SANDORIA and player:getRank(player:getNation()) ~= 10 then
        local sandyMissions = xi.mission.id.sandoria
        local currentMission = player:getCurrentMission(SANDORIA)
        local missionStatus = player:getMissionStatus(player:getNation())

        -- San D'Oria 9-2 "The Heir to the Light"
        if currentMission == sandyMissions.THE_HEIR_TO_THE_LIGHT and missionStatus == 5 then
            player:startEvent(8)

        -- Default
        else
            player:startEvent(514)
        end
    else
        player:startEvent(514)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 8 then
        player:setMissionStatus(player:getNation(), 6)
    elseif csid == 76 then
        finishMissionTimeline(player, 3, csid, option)
    end
end

return entity
