-----------------------------------
-- Area: East Sarutabaruta
--  NPC: Sama Gohjima
--  Involved in Mission: The Horutoto Ruins Experiment (optional)
-- !pos 377 -13 98 116
-----------------------------------
require("scripts/globals/missions")
local ID = require("scripts/zones/East_Sarutabaruta/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.THE_HORUTOTO_RUINS_EXPERIMENT and player:getMissionStatus(player:getNation()) == 1) then
        player:showText(npc, ID.text.SAMA_GOHJIMA_PREDIALOG)
    elseif (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.THE_HORUTOTO_RUINS_EXPERIMENT and player:getMissionStatus(player:getNation()) ~= 1) then
        player:messageSpecial(ID.text.SAMA_GOHJIMA_POSTDIALOG)
    else
        player:startEvent(43)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
