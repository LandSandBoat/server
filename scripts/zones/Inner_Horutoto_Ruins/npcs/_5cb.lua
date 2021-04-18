-----------------------------------
-- Area: Inner Horutoto Ruins
--  NPC: _5cb (Gate of Darkness)
-- !pos -228 0 99 192
-----------------------------------
local ID = require("scripts/zones/Inner_Horutoto_Ruins/IDs")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(WINDURST) == xi.mission.id.windurst.THE_JESTER_WHO_D_BE_KING and
        player:getMissionStatus(player:getNation()) == 9
    then
        player:startEvent(75)
    else
        player:messageSpecial(ID.text.DOOR_FIRMLY_CLOSED)
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 75 then
        player:setMissionStatus(player:getNation(), 10)
    end
end

return entity
