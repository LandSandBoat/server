-----------------------------------
-- Area: La Theine Plateau
--  NPC: Laurisse
-- Involved in Mission: The Rescue Drill
-- !pos -292 28 143 102
-----------------------------------
require("scripts/globals/missions")
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.THE_RESCUE_DRILL) then
        local MissionStatus = player:getCharVar("MissionStatus")

        if (MissionStatus == 5) then
            player:startEvent(106)
        elseif (MissionStatus >= 6 and MissionStatus <= 7) then
            player:startEvent(109)
        elseif (MissionStatus == 8) then
            player:showText(npc, ID.text.RESCUE_DRILL + 21)
        elseif (MissionStatus >= 9) then
            player:showText(npc, ID.text.RESCUE_DRILL + 26)
        else
            player:showText(npc, ID.text.RESCUE_DRILL)
        end
    else
        player:showText(npc, ID.text.RESCUE_DRILL)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 106) then
        player:setCharVar("MissionStatus", 6)
    end

end
