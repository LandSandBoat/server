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

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if
        player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_JESTER_WHO_D_BE_KING and
        player:getCharVar("MissionStatus") == 4 and
        not GetMobByID(ID.mob.JESTER_WHO_D_BE_KING_OFFSET + 0):isSpawned() and
        not GetMobByID(ID.mob.JESTER_WHO_D_BE_KING_OFFSET + 1):isSpawned()
    then
        SpawnMob(ID.mob.JESTER_WHO_D_BE_KING_OFFSET + 0)
        SpawnMob(ID.mob.JESTER_WHO_D_BE_KING_OFFSET + 1)

    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_JESTER_WHO_D_BE_KING and player:getCharVar("MissionStatus") == 5) then
        player:startEvent(71)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 71 then
        player:addKeyItem(tpz.ki.ORASTERY_RING)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ORASTERY_RING)
        player:setCharVar("MissionStatus", 6)
    end
end
