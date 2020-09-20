----------------------------------
-- Area: Fort Karugo Narugo [S]
--  NPC: ???
-- Type: Quest
-- !pos -63 -75 4 96
-----------------------------------
local ID = require("scripts/zones/Fort_Karugo-Narugo_[S]/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local ttsStat = player:getCharVar("TigressStrikesProg")

    if (ttsStat == 1) then
        player:startEvent(102)
    elseif (player:getCharVar("WarLynxKilled") == 1) then
        player:startEvent(103)
    elseif (ttsStat == 2 and not GetMobByID(ID.mob.TIGRESS_STRIKES_WAR_LYNX):isSpawned()) then
        SpawnMob(ID.mob.TIGRESS_STRIKES_WAR_LYNX):updateClaim(player)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 102) then
        player:setCharVar("TigressStrikesProg", 2)
    elseif (csid == 103) then
        player:setCharVar("TigressStrikesProg", 3)
    end
end
