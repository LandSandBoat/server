-----------------------------------
-- Area: La Theine Plateau
--  NPC: Equesobillot
-- Involved in Mission: The Rescue Drill
-- !pos -287 9 284 102
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

        if missionStatus == 2 then
            player:startEvent(101)
        elseif missionStatus == 3 then
            player:showText(npc, ID.text.RESCUE_DRILL + 3)
        elseif missionStatus == 8 then
            if player:getCharVar("theRescueDrillRandomNPC") == 2 then
                player:startEvent(112)
            else
                player:showText(npc, ID.text.RESCUE_DRILL + 21)
            end
        elseif missionStatus == 9 then
            if player:getCharVar("theRescueDrillRandomNPC") == 2 then
                player:showText(npc, ID.text.RESCUE_DRILL + 25)
            else
                player:showText(npc, ID.text.RESCUE_DRILL + 26)
            end
        elseif missionStatus >= 10 then
            player:showText(npc, ID.text.RESCUE_DRILL + 30)
        else
            player:showText(npc, ID.text.RESCUE_DRILL)
        end
    else
        player:showText(npc, ID.text.RESCUE_DRILL + 31)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 101) then
        player:setMissionStatus(player:getNation(), 3)
    elseif (csid == 112) then
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
