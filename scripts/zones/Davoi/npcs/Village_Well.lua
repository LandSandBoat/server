-----------------------------------
-- Area: Davoi
--  NPC: Village Well
-- Involved in Quest: Under Oath
-----------------------------------
local ID = require("scripts/zones/Davoi/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getCharVar("UnderOathCS") == 5 and npcUtil.tradeHas(trade, 1095) then
        player:startEvent(113)
    else
        player:messageSpecial(ID.text.A_WELL)
    end
end

function onTrigger(player, npc)
    if
        player:getCharVar("UnderOathCS") == 5 and
        player:hasKeyItem(tpz.ki.STRANGE_SHEET_OF_PAPER) and
        not player:hasItem(1095) and
        not GetMobByID(ID.mob.ONE_EYED_GWAJBOJ):isSpawned() and
        not GetMobByID(ID.mob.THREE_EYED_PROZPUZ):isSpawned()
    then
        SpawnMob(ID.mob.ONE_EYED_GWAJBOJ):updateClaim(player)
        SpawnMob(ID.mob.THREE_EYED_PROZPUZ):updateClaim(player)
    elseif player:getCharVar("UnderOathCS") == 6 and player:hasKeyItem(tpz.ki.KNIGHTS_CONFESSION) then
        player:startEvent(112) -- read contents of letter
    else
        player:messageSpecial(ID.text.A_WELL)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 113 then
        player:confirmTrade()
        npcUtil.giveKeyItem(player, tpz.ki.KNIGHTS_CONFESSION)
        player:setCharVar("UnderOathCS", 6)
        player:delKeyItem(tpz.ki.STRANGE_SHEET_OF_PAPER)
    end
end
