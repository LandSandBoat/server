-----------------------------------
-- Area: Outer Horutoto Ruins
--  NPC: Gate: Magical Gizmo
-- Involved In Mission: The Heart of the Matter
-- !pos 584 0 -660 194
-----------------------------------
local ID = require("scripts/zones/Outer_Horutoto_Ruins/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if
        player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_HEART_OF_THE_MATTER and
        player:getCharVar("MissionStatus") == 3 and
        player:hasKeyItem(tpz.ki.SOUTHEASTERN_STAR_CHARM)
    then
        player:startEvent(44)
    else
        player:messageSpecial(ID.text.DOOR_FIRMLY_SHUT)
    end

    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 44 then
        player:setCharVar("MissionStatus", 4)
        player:messageSpecial(ID.text.ALL_G_ORBS_ENERGIZED)
        player:delKeyItem(tpz.ki.SOUTHEASTERN_STAR_CHARM)
    end
end
