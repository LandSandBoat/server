-----------------------------------
-- Area: Ru'Aun Gardens
-- NPC:  ??? (Genbu's Spawn)
-- Allows players to spawn the HNM Genbu with a Gem of the North and a Winterstone.
-- !pos 257 -70 517 130
-----------------------------------
local ID = require("scripts/zones/RuAun_Gardens/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, {1424, 1425}) and npcUtil.popFromQM(player, npc, ID.mob.GENBU) then -- Gem of the North and Winterstone
        player:showText(npc, ID.text.SKY_GOD_OFFSET + 5)
        player:confirmTrade()
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.SKY_GOD_OFFSET)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
