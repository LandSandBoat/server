-----------------------------------
-- Area: La Theine Plateau
--  NPC: Narvecaint
-- Involved in Mission: The Rescue Drill
-- !pos -263 22 129 102
-----------------------------------
require("scripts/globals/missions")
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getCurrentMission(SANDORIA) == xi.mission.id.sandoria.THE_RESCUE_DRILL) then
        local missionStatus = player:getMissionStatus(player:getNation())

        if missionStatus == 6 then
            player:startEvent(107)
        elseif missionStatus == 7 then
            player:showText(npc, ID.text.RESCUE_DRILL + 14)
        elseif missionStatus == 8 then
            player:showText(npc, ID.text.RESCUE_DRILL + 21)
        elseif missionStatus >= 9 then
            player:showText(npc, ID.text.RESCUE_DRILL + 26)
        else
            player:showText(npc, ID.text.RESCUE_DRILL)
        end
    else
        player:showText(npc, ID.text.RESCUE_DRILL + 37)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 107) then
        player:setMissionStatus(player:getNation(), 7)
    end
end

return entity
