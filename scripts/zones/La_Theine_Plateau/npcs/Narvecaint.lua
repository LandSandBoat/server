-----------------------------------
-- Area: La Theine Plateau
--  NPC: Narvecaint
-- Involved in Mission: The Rescue Drill
-- !pos -263 22 129 102
-----------------------------------
require("scripts/globals/missions")
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.THE_RESCUE_DRILL) then
        local MissionStatus = player:getCharVar("MissionStatus")

        if (MissionStatus == 6) then
            player:startEvent(107)
        elseif (MissionStatus == 7) then
            player:showText(npc, ID.text.RESCUE_DRILL + 14)
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

    if (csid == 107) then
        player:setCharVar("MissionStatus", 7)
    end

end
