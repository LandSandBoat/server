-----------------------------------
-- Area: La Theine Plateau
--  NPC: Vicorpasse
-- Involved in Mission: The Rescue Drill
-- !pos -344 37 266 102
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getCurrentMission(SANDORIA) == xi.mission.id.sandoria.THE_RESCUE_DRILL) then
        local missionStatus = player:getMissionStatus(player:getNation())

        if missionStatus == 4 then
            player:startEvent(108)
        elseif missionStatus >= 5 and missionStatus <= 7 then
            player:showText(npc, ID.text.RESCUE_DRILL + 19)
        elseif missionStatus == 8 then
            player:showText(npc, ID.text.RESCUE_DRILL + 21)
        elseif missionStatus == 9 then
            player:showText(npc, ID.text.RESCUE_DRILL + 26)
        elseif missionStatus == 10 then
            player:startEvent(115)
        elseif missionStatus == 11 then
            player:showText(npc, ID.text.RESCUE_DRILL + 29, xi.ki.RESCUE_TRAINING_CERTIFICATE)
        else
            player:startEvent(5)
        end
    else
        player:showText(npc, ID.text.RESCUE_DRILL + 38)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 108) then
        player:setMissionStatus(player:getNation(), 5)
    elseif (csid == 115) then
        player:addKeyItem(xi.ki.RESCUE_TRAINING_CERTIFICATE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.RESCUE_TRAINING_CERTIFICATE)
        player:setCharVar("theRescueDrillRandomNPC", 0)
        player:setMissionStatus(player:getNation(), 11)
    end
end

return entity
