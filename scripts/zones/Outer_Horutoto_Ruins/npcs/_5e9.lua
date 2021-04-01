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
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(WINDURST) == xi.mission.id.windurst.THE_HEART_OF_THE_MATTER and
        player:getCharVar("MissionStatus") == 3 and
        player:hasKeyItem(xi.ki.SOUTHEASTERN_STAR_CHARM)
    then
        player:startEvent(44)
    else
        player:messageSpecial(ID.text.DOOR_FIRMLY_SHUT)
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 44 then
        player:setCharVar("MissionStatus", 4)
        player:messageSpecial(ID.text.ALL_G_ORBS_ENERGIZED)
        player:delKeyItem(xi.ki.SOUTHEASTERN_STAR_CHARM)
    end
end

return entity
