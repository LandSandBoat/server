-----------------------------------
-- Area: East Sarutabaruta
--  NPC: Sama Gohjima
--  Involved in Mission: The Horutoto Ruins Experiment (optional)
-- !pos 377 -13 98 116
-----------------------------------
require("scripts/globals/missions")
local ID = require("scripts/zones/East_Sarutabaruta/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_HORUTOTO_RUINS_EXPERIMENT and player:getCharVar("MissionStatus") == 1) then
        player:showText(npc, ID.text.SAMA_GOHJIMA_PREDIALOG)
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_HORUTOTO_RUINS_EXPERIMENT and player:getCharVar("MissionStatus") ~= 1) then
        player:messageSpecial(ID.text.SAMA_GOHJIMA_POSTDIALOG)
    else
        player:startEvent(43)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
