-----------------------------------
-- Area: Quicksand Caves
--  NPC: Fountain of Kings
-- !pos 567 18 -939 208
-----------------------------------
local ID = require("scripts/zones/Quicksand_Caves/IDs")
require("scripts/globals/missions")
require("scripts/globals/keyitems")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.COMING_OF_AGE and player:getCharVar("MissionStatus") == 2
        and not GetMobByID(ID.mob.VALOR):isSpawned() and not GetMobByID(ID.mob.HONOR):isSpawned()) then
        SpawnMob(ID.mob.VALOR)
        SpawnMob(ID.mob.HONOR)
    elseif (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.COMING_OF_AGE and player:getCharVar("MissionStatus") == 3
        and not GetMobByID(ID.mob.VALOR):isSpawned() and not GetMobByID(ID.mob.HONOR):isSpawned()) then
        player:addKeyItem(tpz.ki.DROPS_OF_AMNIO)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.DROPS_OF_AMNIO)
    else
        player:messageSpecial(ID.text.POOL_OF_WATER)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
