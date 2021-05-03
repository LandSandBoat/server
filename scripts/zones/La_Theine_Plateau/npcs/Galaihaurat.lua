-----------------------------------
-- Area: La Theine Plateau
--  NPC: Galaihaurat
-- Involved in Mission: The Rescue Drill
-- !pos -482 -7 222 102
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

        if missionStatus == 0 then
            player:startEvent(110)
        elseif missionStatus == 2 then
            player:showText(npc, ID.text.RESCUE_DRILL + 16)
        elseif missionStatus == 8 then
            if player:getCharVar("theRescueDrillRandomNPC") == 1 then
                player:startEvent(114)
            else
                player:showText(npc, ID.text.RESCUE_DRILL + 21)
            end
        elseif missionStatus == 9 then
            if player:getCharVar("theRescueDrillRandomNPC") == 1 then
                player:showText(npc, ID.text.RESCUE_DRILL + 25)
            else
                player:showText(npc, ID.text.RESCUE_DRILL + 26)
            end
        elseif missionStatus >= 10 then
            player:showText(npc, ID.text.RESCUE_DRILL + 30)
        else
            player:showText(npc, ID.text.RESCUE_DRILL)
        end
    elseif player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_RESCUE_DRILL) then
        player:showText(npc, ID.text.RESCUE_DRILL + 39)
    else
        player:showText(npc, ID.text.RESCUE_DRILL)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 110) then
        player:setMissionStatus(player:getNation(), 2)
    elseif (csid == 114) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 16535) -- Bronze Sword
        else
            player:addItem(16535)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 16535) -- Bronze Sword
            player:setMissionStatus(player:getNation(), 9)
        end
    end
end

return entity
