-----------------------------------
-- Area: Outer Horutoto Ruins
--  NPC: Cracked Wall
-- Involved In Mission: The Jester Who'd Be King
-- !pos -424.255 -1.909 619.995
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
        player:getCurrentMission(WINDURST) == xi.mission.id.windurst.THE_JESTER_WHO_D_BE_KING and
        player:getCharVar("MissionStatus") == 4 and
        not GetMobByID(ID.mob.JESTER_WHO_D_BE_KING_OFFSET + 0):isSpawned() and
        not GetMobByID(ID.mob.JESTER_WHO_D_BE_KING_OFFSET + 1):isSpawned()
    then
        SpawnMob(ID.mob.JESTER_WHO_D_BE_KING_OFFSET + 0)
        SpawnMob(ID.mob.JESTER_WHO_D_BE_KING_OFFSET + 1)

    elseif (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.THE_JESTER_WHO_D_BE_KING and player:getCharVar("MissionStatus") == 5) then
        player:startEvent(71)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 71 then
        player:addKeyItem(xi.ki.ORASTERY_RING)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.ORASTERY_RING)
        player:setCharVar("MissionStatus", 6)
    end
end

return entity
