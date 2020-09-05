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

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.THE_RESCUE_DRILL) then
        local MissionStatus = player:getCharVar("MissionStatus")

        if (MissionStatus == 4) then
            player:startEvent(108)
        elseif (MissionStatus >= 5 and MissionStatus <= 7) then
            player:showText(npc, ID.text.RESCUE_DRILL + 19)
        elseif (MissionStatus == 8) then
            player:showText(npc, ID.text.RESCUE_DRILL + 21)
        elseif (MissionStatus == 9) then
            player:showText(npc, ID.text.RESCUE_DRILL + 26)
        elseif (MissionStatus == 10) then
            player:startEvent(115)
        elseif (MissionStatus == 11) then
            player:showText(npc, ID.text.RESCUE_DRILL + 30)
        else
            player:startEvent(5)
        end
    else
        player:startEvent(5)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 108) then
        player:setCharVar("MissionStatus", 5)
    elseif (csid == 115) then
        player:addKeyItem(tpz.ki.RESCUE_TRAINING_CERTIFICATE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.RESCUE_TRAINING_CERTIFICATE)
        player:setCharVar("theRescueDrillRandomNPC", 0)
        player:setCharVar("MissionStatus", 11)
    end

end
