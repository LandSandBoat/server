-----------------------------------
-- Area: Giddeus
--  NPC: ???
-- Involved In Quest: Dark Legacy
-- !pos -58 0 -449 145
-----------------------------------
local ID = require("scripts/zones/Giddeus/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    local darkLegacyCS = player:getCharVar("darkLegacyCS")

    if (
        (darkLegacyCS == 3 or darkLegacyCS == 4) and
        npcUtil.tradeHas(trade, 4445) and
        not GetMobByID(ID.mob.VAA_HUJA_THE_ERUDITE):isSpawned()
    ) then -- Yagudo Cherries
        player:confirmTrade()
        player:messageSpecial(ID.text.SENSE_OF_FOREBODING)
        SpawnMob(ID.mob.VAA_HUJA_THE_ERUDITE):updateClaim(player)
    end
end

function onTrigger(player, npc)
    if (player:getCharVar("darkLegacyCS") == 5 and not player:hasKeyItem(tpz.ki.DARKSTEEL_FORMULA)) then
        npcUtil.giveKeyItem(player, tpz.ki.DARKSTEEL_FORMULA)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
