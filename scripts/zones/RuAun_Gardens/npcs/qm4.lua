-----------------------------------
-- Area: Ru'Aun Gardens
-- NPC:  ??? (Suzaku's Spawn)
-- Allows players to spawn the HNM Suzaku with a Gem of the South and a Summerstone.
-- !pos -514 -70 -264 130
-----------------------------------
local ID = require("scripts/zones/RuAun_Gardens/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, {1420, 1421}) and npcUtil.popFromQM(player, npc, ID.mob.SUZAKU) then -- Gem of the South and Summerstone
        player:showText(npc, ID.text.SKY_GOD_OFFSET + 7)
        player:confirmTrade()
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.SKY_GOD_OFFSET + 3)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
